class AddFileToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :file, :string, index: true
  end
end
