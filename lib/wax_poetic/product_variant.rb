require 'active_model'

module WaxPoetic
  # A PORO for integrating the Spree::Product and Spree::Variant with a
  # Release and its various variants. All releases and tracks follow the
  # same "price bump" rules for downloads: the MP3 price is what is
  # entered into the release/track/etc. form, and WAV/OSE formats are
  # "bumped" to higher prices. This class is used to generate
  # properly-formatted attributes for a +Spree::Variant+ when it is
  # saved to the database via +WaxPoetic::Product+'s save method.
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

    # Public: The Spree::Product this object will be attaching Spree::Variants
    # to.
    # @type Spree::Product
    attr_accessor :product
    validates :product, presence: true

    # Public: The type of variant to create. Can be any one of MP3, WAV or OSE.
    # @type String
    attr_accessor :type
    validates :type, presence: true, inclusion: { in: TYPES }

    # Public: Iterates through each of the types in +TYPES+ and instantiate a new
    # ProductVariant object for this project and each type.
    #
    # @returns [Array]
    def self.from(product)
      TYPES.map { |type| create product: product, type: type }
    end

    # Public: Creates a new ProductVariant with given attributes and runs
    # validators on it before returning the ProductVariant back.
    #
    # @returns [ProductVariant]
    def self.create(attributes = {})
      variant = new(attributes)
      variant.valid?
      variant
    end

    # Public: Any object that implements the +Saleable+ module, and has
    # methods for instantiating these integration objects as well as for
    # dealing with the associations between Spree objects.
    #
    # @returns [Release, Track]
    def saleable
      product.saleable
    end

    # Public: A set of attributes which are going to be assigned to
    # the +Spree::Variant+ on creation.
    #
    # @returns [Hash]
    def attributes
      {
        sku: sku,
        price: price,
        option_values: option_values,
        images: images,
        is_master: is_master?
      }
    end

    # Internal: Generate the SKU from the catalog number and type of
    # product. So for an open-source edition of "WXP007", this will be
    # +WXP007-OSE+.
    #
    # @returns [String]
    def sku
      @sku ||= "#{saleable.catalog_number}-#{type}"
    end

    # Internal: Calculate the price for this +Spree::Variant+, bumping
    # it from the base price (for MP3) assigned on the saleable object
    # itself.
    #
    # @returns [Number]
    def price
      @price ||= saleable.price + BUMPS[type]
    end

    # Internal: Assign a custom option value to show users what kind of
    # product this is.
    #
    # @returns [Array]
    def option_values
      @option_values ||= format_option.option_values.where(name: type)
    end

    # Internal: Uploaded images for this product.
    #
    # @returns [Array] a collection of +Spree::Image+ records.
    def images
      @images ||= [
        Spree::Image.new(
          attachment: image,
          alt: saleable.name,
          viewable: saleable
        )
      ]
    end

    private

    # Internal: The Spree::OptionType that has been bootstrapped into
    # the database for this kind of variant. It helps define the "kind"
    # of variant this is.
    #
    # @returns [Spree::OptionType]
    def format_option
      Spree::OptionType.find_by_name 'format'
    end

    # Internal: Use the image_file of the saleable object as the file to
    def image
      return unless saleable.image_filepath.present?
      File.open(saleable.image_filepath)
    end

    # Internal: The master variant is the first variant created, the one
    # for the most popular audio format, MP3. If the +type+ of this
    # ProductVariant is "MP3", it is considered the master variant of
    # the parent Product.
    #
    # @returns [Boolean]
    def is_master?
      type == TYPES.first
    end
  end
end
