class AddDownloadToSpreeOrders < ActiveRecord::Migration
  def change
    add_reference :spree_orders, :download, index: true
  end
end
