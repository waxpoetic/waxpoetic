class AddPriceToReleases < ActiveRecord::Migration
  def change
    add_column :releases, :price, :money
  end
end
