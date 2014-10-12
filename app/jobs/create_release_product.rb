# Create Spree products for the Release so it can be sold on the online
# store.
class CreateReleaseProduct < ActiveJob::Base
  attr_reader :product

  def perform(given_release)
    @release = given_release
    @product = Spree::Product.new release.product_attributes

    if saved?
      logger.info "Product and Release saved"

      if product.images.create(image_attributes)
        logger.info "Image created. Creating variants."
        CreateProductVariants.enqueue product
      else
        logger.warn "Image not created. No variants created."
      end
    else
      logger.error "Product did not save: #{product.errors.full_messages.join(', ')}"
    end
  end

  def release
    @release.try :decorate
  end

  def saved?
    product.save && release.update_attributes(product_id: product.id)
  end

  def image_attributes
    {
      attachment: File.new(release.cover.file.file),
      alt: release.decorate.title,
      viewable: release
    }
  end
end
