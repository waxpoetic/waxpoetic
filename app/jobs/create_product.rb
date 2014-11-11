# Create Spree products for Releases and Tracks.
class CreateProduct < ActiveJob::Base
  attr_reader :product, :saleable

  def perform(saleable)
    product = saleable.build_product saleable.product_attributes

    if product.save
      UploadProductImage.enqueue product
      CreateProductVariants.enqueue product
      saleable.try :after_create_product
    end
  end
end
