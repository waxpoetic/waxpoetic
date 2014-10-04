class AddProductIdToReleases < ActiveRecord::Migration
  def change
    add_reference :releases, :product, index: true
  end
end
