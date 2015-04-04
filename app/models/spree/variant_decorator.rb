Spree::Variant.class_eval do
  def saleable_type
    product.saleable_type
  end
end
