class CreateProductVariants < ActiveJob::Base
  attr_reader :product

  class Variant
    # The amount of money the initially set price is bumped for
    # variant releases, such as high-quality or open-source releases.
    BUMPS = {
      'MP3' => 0, # mp3s are the master price (the lowest)
      'WAV' => 0.59,
      'OSE' => 10.00
    }

    # The type of variants we'll be creating alongside this product.
    TYPES = %w(MP3 WAV OSE)

    attr_accessor :sku, :price, :option_values

    def initialize(saleable, variant)
      @sku = "#{saleable.catalog_number}-#{variant}"
      @price = saleable.price + BUMPS[variant]
      @option_values = format_option.option_values.where(name: variant)
    end

    def self.attributes_for(saleable, variant)
      new(saleable, variant).attributes
    end

    def attributes
      { sku: sku, price: price, option_values: option_values }
    end

    private
    def format_option
      Spree::OptionType.find_by_name 'format'
    end
  end

  def perform(product)
    binding.pry if product.saleable.nil?

    Variant::TYPES.each do |variant_type|
      product.variants.create Variant.attributes_for(product.saleable, variant_type)
    end
  end
end
