# A model that can be sold in the Wax Poetic online store.
module Saleable
  extend ActiveSupport::Concern

  # Default attribute mappings.
  DEFAULT_MAPPINGS = {
    :name => :name,
    :description => :description,
    :meta_description => :description,
    :available_on => :created_at,
    :image => :image,
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
  end

  module ClassMethods
    def has_product(with_attr_mappings={})
      self.product_attr_mappings = DEFAULT_MAPPINGS.merge(with_attr_mappings)
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
    decorate.send self.class.product_attr_mappings[key]
  end
end
