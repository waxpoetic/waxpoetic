class CreateReleaseProduct < ActiveJob::Base
  def perform(release)
    product = Spree::Product.new release.product_attributes

    if product.save
      release.update_attributes product: product
      CreateProductVariants.enqueue product
    else
      logger.error "Product did not save: #{product.errors.full_messages.join(', ')}"
    end
  end
end
