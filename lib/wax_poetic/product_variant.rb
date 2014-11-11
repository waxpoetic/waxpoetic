require 'active_model'

module WaxPoetic
  # A PORO for integrating the Spree::Product and Spree::Variant with a
  # Release and its various variants. All releases and tracks follow the
  # same "price bump" rules for downloads: the MP3 price is what is
  # entered into the release/track/etc. form, and WAV/OSE formats are
  # "bumped" to higher prices.
  #
  # A ProductVariant requires that 
  class ProductVariant
    include ActiveModel::Model

    # The amount of money the initially set price is bumped for
    # variant releases, such as high-quality or open-source releases.
    BUMPS = {
      'MP3' => 0, # mp3s are the master price (the lowest)
      'WAV' => 0.59,
      'OSE' => 10.00
    }

    # The type of variants we'll be creating alongside this product.
    TYPES = %w(MP3 WAV OSE)

    attr_accessor :saleable, :variant

    def attributes
      { sku: sku, price: price, option_values: option_values }
    end

    def sku
      @sku ||= "#{saleable.catalog_number}-#{variant}"
    end

    def price
      @price ||= saleable.price + BUMPS[variant]
    end

    def option_values
      @option_values ||= format_option.option_values.where(name: variant)
    end

    private
    def format_option
      Spree::OptionType.find_by_name 'format'
    end
  end
end
