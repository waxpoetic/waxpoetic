class AddPreviewDurationToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :preview_starts_at, :integer, default: 0
    add_column :tracks, :preview_ends_at, :integer, default: 120
  end
end
