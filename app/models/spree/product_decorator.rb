# Store a reference to the catalog record this product represents within
# the product table.
Spree::Product.class_eval do
  belongs_to :saleable, polymorphic: true
end
