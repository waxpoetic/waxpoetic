require 'active_model'
require 'wax_poetic/product_variant'

module WaxPoetic
  # Transforms catalog models into a +Spree::Product+ record so they can
  # be sold in the online store. Typically instantiated by the CreateProduct
  # job after the successful save of a +Saleable+ model, it presents the
  # Saleable record's data in a consistent way so it may be saved into
  # the +Spree::Product+'s table.
  class Product
    # Internal: A collection of fields that should be lifted from the decorator as
    # metadata for the Spree::Product
    cattr_accessor :metadata_fields
    self.metadata_fields ||= []

    # The saleable record used to back this PORO.
    attr_reader :saleable

    # Internal: Instantiate a new Product class with the given saleable record.
    def initialize(with_saleable_record)
      @saleable = with_saleable_record.decorate
    end

    # Public: Add a new metadata field to the hash. Define the attribute that is
    # to be fetched from the saleable record's decorator.
    def self.metadata_field(attr_name)
      self.metadata_fields << attr_name
    end

    # Public: Instantiate a Product, which defines and saves a new
    # Spree::Product from a Saleable object.
    #
    # @returns [Boolean]
    def self.create(saleable)
      product = new(saleable)
      product.save
      product
    end

    # Public: Fetch a new product presenter for the given saleable record.
    def self.for(saleable)
      "#{saleable.class.name}Product".constantize.create(saleable)
    rescue LoadError
      logger.warn "#{saleable.class.name}Product presenter not found"
      Product.new(saleable)
    end

    # Public: Persist this record to the datbaase.
    def save
      create_product && create_variants && create_properties
    end

    # Public: Tests if there are any +Spree::Product+ records that
    # already exist for this Saleable model.
    def persisted?
      Spree::Product.where(name: name).any?
    end

    # Public: Use the name of the saleable object.
    delegate :name, to: :saleable

    # Public: Use the description of the saleable object for the text
    # description
    delegate :description, to: :saleable

    # Public: Use the description of the saleable object for a <meta>
    # tag description.
    delegate :meta_description, to: :saleable

    # Public: Use the created_at timestamp of the saleable object.
    delegate :available_on, to: :saleable

    # Public: Use the price of the saleable object.
    delegate :price, to: :saleable

    # Public: Use the default shipping category in Spree.
    def shipping_category
      Spree::ShippingCategory.find_by_name 'Default'
    end

    # Public: A collection of +WaxPoetic::ProductVariant+ objects which
    # wrap +Spree::Variant+ objects for the purpose of insertion into
    # the database with this query via mass-assignment.
    #
    # @returns [Array] of ProductVariant objects
    def variants
      @variants ||= ProductVariant.from(self)
    end

    # Deprecated: Hash of metadata compiled from each `metadata_field` entry. This
    # wil be an empty Hash if no metadata_fields were defined.
    def metadata
      self.class.metadata_fields.map do |field|
        {
          property: property_for(field.to_s.titleize),
          value: saleable.send(field)
        }
      end
    end

    # Internal: Hash of attributes passed to the Spree::Product when saved.
    def attributes
      {
        name: name,
        description: description,
        meta_description: meta_description,
        available_on: available_on,
        shipping_category: shipping_category,
        price: price
      }
    end

    def spree_product
      @spree_product ||= saleable.product || saleable.build_product(attributes)
    end

    private

    def create_product
      spree_product.save
    end

    def create_variants
      variants.all? do |product_variant|
        spree_product.variants.create product_variant.attributes
      end
    end

    def create_properties
      metadata.all? { |property| spree_product.product_properties.create(property) }
    end

    def property_for(name)
      Spree::Property.find_or_create_by name: name
    end
  end
end
