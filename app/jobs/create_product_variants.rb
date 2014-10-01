class CreateProductVariants < ActiveJob::Base
  # The type of variants we'll be creating alongside this product.
  VARIANTS = %w(MP3 WAV OSE)

  # The amount of money the initially set price is bumped for
  # high-quality releases, delivered in WAV format.
  WAV_BUMP = 0.59

  # The amount of money the initially set price is bumped for
  # open-source releases, delivered in ZIP format.
  OSE_BUMP = 10.00

  def perform(product)
    VARIANTS.each_with_index do |index, variant|
      variant = product.variants.build \
        sku: sku_for(product, variant),
        price: price_of(product.price, variant),
        position: index
        option_values: [
          {
            name: "#{variant} format",
            presentation: variant
            option_type_name: 'format'
          }
        ]

      unless variant.save
        logger.error "Variant did not save: #{variant.errors.full_messages.join(', ')}"
      end
    end
  end

  private
  def price_of(base_price, variant)
    base_price + const_get("#{variant}_BUMP")
  end

  def sku_for(product, variant)
    "#{release_of(product).catalog_number}-#{variant}"
  end

  def release_of(product)
    Release.where(product_id: product.id).first
  end
end
