# Create Spree products for the Release so it can be sold on the online
# store.
class CreateReleaseProduct < ActiveJob::Base
  attr_accessor :release, :product

  def perform(release)
    @release = release
    @product = Spree::Product.new release.product_attributes

    if product.save
      release.update_attributes product: product
      CreateProductVariants.enqueue product
    else
      logger.error "Product did not save: #{product.errors.full_messages.join(', ')}"
    end
  end
end
