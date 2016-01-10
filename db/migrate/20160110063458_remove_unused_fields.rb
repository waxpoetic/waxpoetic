class RemoveUnusedFields < ActiveRecord::Migration
  def change
    remove_column :releases, :price, :money
    remove_column :releases, :file, :string
    remove_column :releases, :product_id, :integer
    remove_column :releases, :open_source_package, :string

    remove_column :tracks, :product_id, :integer
    remove_column :tracks, :price, :money
  end
end
