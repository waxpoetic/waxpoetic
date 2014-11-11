require 'wax_poetic/product_variant'

# Create all variants of a given digital download record.

class CreateProductVariants < ActiveJob::Base
  def perform(product)
    WaxPoetic::ProductVariant::TYPES.each do |type|
      variant = WaxPoetic::ProductVariant.new saleable: product.saleable, variant: type
      product.variants.create variant.attributes
    end
  end
end
