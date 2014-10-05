class AddNumberToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :number, :integer
  end
end
