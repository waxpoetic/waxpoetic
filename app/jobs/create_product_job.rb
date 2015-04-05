# Create a Spree::Product record for any saleable model so that it can
# be sold in the online store. The "catalog record" for the saleable
# model is the central source of truth by which products and variants
# gain all of their data. For this reason, Spree::Product and
# Spree::Variant records are read-only, they can not be updated through
# the front-end of the app.
class CreateProductJob < ActiveJob::Base
  attr_reader :product, :saleable

  def perform(saleable)
    WaxPoetic::Product.create(saleable)
  end
end
