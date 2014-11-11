# Copies the image uploaded in the saleable model's form to the
# Spree::Product record, and "re-uploads" it in the Spree world so that
# the store takes the same picture as the catalog record.
class UploadProductImage < ActiveJob::Base
  def perform(saleable)
    saleable.product.images.create saleable.product_image_attributes
    saleable.product.update_attributes product_properties_attributes: saleable.product_metadata
    saleable.has_product?
  end
end
