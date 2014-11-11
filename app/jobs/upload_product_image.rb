class UploadProductImage < ActiveJob::Base
  def perform(saleable)
    saleable.product.images.create saleable.product_image_attributes
    saleable.product.update_attributes product_properties_attributes: saleable.product_metadata
    saleable.has_product?
  end
end
