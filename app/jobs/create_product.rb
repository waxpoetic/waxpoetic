# Create Spree products for Releases and Tracks.
class CreateProduct < ActiveJob::Base
  attr_reader :product, :saleable

  def perform(saleable)
    product = saleable.create_product saleable.product_attributes
    return false unless saleable.product.present?
    saleable.product.images.create saleable.product_image_attributes
    saleable.product.update_attributes product_properties_attributes: saleable.product_metadata
    CreateProductVariants.enqueue saleable.product
    saleable.try :after_create_product
    saleable.has_product?
  end
end
