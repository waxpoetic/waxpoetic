# A model that can be sold in the Wax Poetic online store. By including
# this module and specifying `has_product`, you can expect that this
# object will create itself as a Spree::Product and use the mappings you define
# as its attributes.
module Saleable
  extend ActiveSupport::Concern

  # Default attribute mappings.
  DEFAULT_MAPPINGS = {
    :name => :name,
    :description => :description,
    :meta_description => :description,
    :available_on => :created_at,
    :image => :image,
    :price => :price,
    :shipping_category => :default_shipping_category,
    :metadata => []
  }

  # Attributes that will be used to create the Spree::Product
  PRODUCT_ATTRIBUTES = %w(
    name description meta_description available_on
    shipping_category price
  )

  included do
    cattr_accessor :product_attr_mappings
    belongs_to :product, class_name: 'Spree::Product'
    after_commit :create_product, :on => :create
    scope :without_product, -> { where product_id: nil }
    scope :with_product, -> { where.not product_id: nil }
  end

  module ClassMethods
    # Set up this saleable model's product attribute mappings:
    #
    #   has_product :name => :title
    #
    # It uses methods on your decorator.
    def has_product(with_attr_mappings={})
      self.product_attr_mappings = DEFAULT_MAPPINGS.merge(with_attr_mappings)
    end

    def has_product?
      true
    end
  end

  # Attributes given to the Spree::Product when created.
  def product_attributes
    PRODUCT_ATTRIBUTES.reduce({}) do |hash, attr_name|
      hash.merge attr_name => product_attribute_for(attr_name)
    end
  end

  # Attributes given to the Spree::Image when created.
  def product_image_attributes
    {
      attachment: product_attribute_for(:image),
      alt: product_attribute_for(:name),
      viewable: self
    }
  end

  # Reduce the given array of metadata mappings into a hash suitable for
  # the metadata params field.
  def product_metadata
    self.class.product_attr_mappings[:metadata].reduce({}) do |hash, field|
      hash.merge property_name: field.titleize, value: decorate.send(field)
    end
  end

  # Find the mapped product attribute for the given Spree key.
  def product_attribute_for(key)
    decorate.send self.class.product_attr_mappings[key.to_sym]
  end

  # Create the Spree::Product for this model and begin selling it on
  # the online store. Note that this will *actually* begin selling
  # whenever the `available_on` date is met.
  def create_product
    CreateProduct.enqueue self
  end
end
