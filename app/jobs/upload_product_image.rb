# Copies the image uploaded in the saleable model's form to the
# Spree::Product record, and "re-uploads" it in the Spree world so that
# the store takes the same picture as the catalog record.
class UploadProductImage < ActiveJob::Base
  def perform(master_variant)
    master_variant.update_attributes(
      product_properties_attributes: saleable.product_metadata
    )
    saleable.has_product?
  end
end
