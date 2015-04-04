require 'wax_poetic/product'

# A model that can be sold in the Wax Poetic online store. By including
# this module and specifying `has_product`, you can expect that this
# object will create itself as a Spree::Product and use the mappings you define
# as its attributes.
module Saleable
  extend ActiveSupport::Concern

  included do
    cattr_accessor :product_attr_mappings
    has_one :product, :as => :saleable, :class_name => 'Spree::Product'
    after_commit :copy_to_product, :unless => :has_product?
    scope :without_product, -> { where product_id: nil }
    scope :with_product, -> { where.not product_id: nil }
    define_model_callbacks :create_product
  end

  # A decorator for the Spree::Product data.
  def productifier
    @productifier ||= WaxPoetic::Product.for(self)
  end

  # Attributes given to the Spree::Product when created.
  def product_attributes
    productifier.attributes
  end

  # Create the Spree::Product for this model and begin selling it on
  # the online store. Note that this will *actually* begin selling
  # whenever the `available_on` date is met.
  def copy_to_product
    run_callbacks :create_product do
      CreateProduct.perform_later self
    end
  end

  # Test if the product was created and populated successfully.
  def has_product?
    product.present? && product.images.any?
  end

  def image_filepath
    image.file.file
  end
end
