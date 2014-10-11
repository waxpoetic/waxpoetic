# Create Spree products for the Release so it can be sold on the online
# store.
class CreateReleaseProduct < ActiveJob::Base
  attr_reader :product

  def perform(given_release)
    @release = given_release
    @product = Spree::Product.new release.product_attributes

    if product.save
      release.update_attributes product: product
      product.images.create \
        attachment: release.cover.file,
        alt: release.decorate.title,
        viewable: release
      CreateProductVariants.enqueue product
    else
      logger.error "Product did not save: #{product.errors.full_messages.join(', ')}"
    end
  end

  def release
    @release.try :decorate
  end
end
