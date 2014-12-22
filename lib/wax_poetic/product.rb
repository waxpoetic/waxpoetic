require 'active_model'

module WaxPoetic
  class Product
    include ActiveModel::Model

    # Internal: A collection of fields that should be lifted from the decorator as
    # metadata for the Spree::Product
    cattr_accessor :metadata_fields

    # The saleable record used to back this PORO.
    attr_reader :saleable

    # Internal: Instantiate a new Product class with the given saleable record.
    def initialize(with_saleable_record)
      @saleable = with_saleable_record.decorate
    end

    # Public: Add a new metadata field to the hash. Define the attribute that is
    # to be fetched from the saleable record's decorator.
    def self.metadata_field(attr_name)
      @metadata_fields ||= []
      @metadata_fields << attr_name
    end

    # Public: Use the name of the saleable object.
    def name
      saleable.name
    end

    # Public: Use the description of the saleable object for the text
    # description
    def description
      saleable.description
    end

    # Public: Use the description of the saleable object for a <meta>
    # tag description.
    def meta_description
      saleable.description
    end

    # Public: Use the created_at timestamp of the saleable object.
    def available_on
      saleable.created_at
    end

    # Public: Use the image_file of the saleable object.
    def image
      File.open(saleable.image_filepath)
    end

    # Public: Use the price of the saleable object.
    def price
      saleable.price
    end

    # Public: Use the default shipping category in Spree.
    def shipping_category
      Spree::ShippingCategory.find_by_name 'Default'
    end

    # Internal: Hash of metadata compiled from each `metadata_field` entry. This
    # wil be an empty Hash if no metadata_fields were defined.
    def metadata
      self.class.metadata_fields.each_with_index.reduce({}) do |hash, (field,index)|
        hash.merge index.to_s => {
          property_name: field.titleize,
          value: saleable.decorate.send(field)
        }
      end
    end

    # Internal: Hash of attributes passed to the Spree::Product when saved.
    def attributes
      {
        :name => name,
        :description => description,
        :meta_description => description,
        :available_on => created_at,
        :image => {
          attachment: image,
          alt: name,
          viewable: saleable
        },
        :price => price,
        :shipping_category => default_shipping_category,
        :metadata => metadata
      }
    end
  end
end
