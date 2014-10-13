class CreateProductVariants < ActiveJob::Base
  # The type of variants we'll be creating alongside this product.
  VARIANTS = %w(MP3 WAV OSE)

  # The amount of money the initially set price is bumped for
  # variant releases, such as high-quality or open-source releases.
  BUMPS = {
    'MP3' => 0, # mp3s are the master price (the lowest)
    'WAV' => 0.59,
    'OSE' => 10.00
  }

  def perform(product)
    VARIANTS.each_with_index do |variant, index|
      product_variant = product.variants.build(
        sku: sku_for(product, variant),
        price: price_of(release_of(product).price, variant),
        option_values: format_option.option_values.where(name: variant)
      )

      if product_variant.save
        logger.info "Saved variant for Product #{product.id}"
      else
        logger.error "Variant did not save: #{product_variant.errors.full_messages.join(', ')}"
      end
    end
  end

  private
  def price_of(master_price, variant)
    master_price + BUMPS[variant]
  end

  def sku_for(product, variant)
    "#{release_of(product).catalog_number}-#{variant}"
  end

  def release_of(product)
    Release.where(product_id: product.id).first
  end

  def format_option
    Spree::OptionType.find_by_name 'format'
  end
end
