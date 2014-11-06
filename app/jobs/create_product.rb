# Create Spree products for Releases and Tracks.
class CreateProduct < ActiveJob::Base
  attr_reader :product, :saleable

  def perform(saleable)
    saleable.product.create saleable.product_attributes
    saleable.product.images.create saleable.product_image_attributes
    saleable.product.update_attributes product_properties_attributes: saleable.product_metadata
    CreateProductVariants.enqueue saleable.product
    #saleable.send :after_create_product
    saleable.product.present?
  end
end
