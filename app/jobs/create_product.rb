# Create a Spree::Product record for any saleable model so that it can
# be sold in the online store. The "catalog record" for the saleable
# model is the central source of truth by which products and variants
# gain all of their data. For this reason, Spree::Product and
# Spree::Variant records are read-only, they can not be updated through
# the front-end of the app.
class CreateProduct < ActiveJob::Base
  attr_reader :product, :saleable

  def perform(saleable)
    product = saleable.build_product saleable.product_attributes

    if product.save
      UploadProductImage.enqueue saleable
      CreateProductVariants.enqueue product
      saleable.after_create_product
    end
  end
end
