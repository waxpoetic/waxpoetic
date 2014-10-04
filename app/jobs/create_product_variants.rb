class CreateProductVariants < ActiveJob::Base
  attr_reader :product

  # The type of variants we'll be creating alongside this product.
  VARIANTS = %w(MP3 WAV OSE)

  # The amount of money the initially set price is bumped for
  # variant releases, such as high-quality or open-source releases.
  BUMPS = {
    'WAV' => 0.59,
    'OSE' => 10.00
  }

  def perform(product)
    @product = product
    VARIANTS.each_with_index do |variant, index|
      variant = product.variants.build(
        sku: sku_for(product, variant),
        price: price_of(release_of(product).price, variant),
        position: index,
        option_values: option_values_for(variant),
        is_master: (variant == 'MP3')
      )

      unless variant.save
        logger.error "Variant did not save: #{variant.errors.full_messages.join(', ')}"
      end
    end
  end

  private
  def price_of(base_price, variant)
    return base_price unless BUMPS[variant].present?
    base_price + BUMPS[variant]
  end

  def sku_for(product, variant)
    "#{release_of(product).catalog_number}-#{variant}"
  end

  def release_of(product)
    Release.where(product_id: product.id).first
  end

  def option_values_for(variant)
    [
      Spree::OptionValue.new(
        name: "#{variant} format",
        presentation: variant,
      )
    ]
  end
end
