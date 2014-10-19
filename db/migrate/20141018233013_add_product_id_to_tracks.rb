class AddProductIdToTracks < ActiveRecord::Migration
  def change
    add_reference :tracks, :product, index: true
  end
end
