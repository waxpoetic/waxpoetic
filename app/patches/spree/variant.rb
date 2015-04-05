Spree::Variant.class_eval do
  delegate :saleable_type, to: :product
  delegate :saleable_id, to: :product
  delegate :saleable, to: :product
end
