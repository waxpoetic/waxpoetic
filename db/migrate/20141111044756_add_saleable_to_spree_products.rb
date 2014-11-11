class AddSaleableToSpreeProducts < ActiveRecord::Migration
  def change
    add_reference :spree_products, :saleable, index: true, polymorphic: true
  end
end
