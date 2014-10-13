class AddShortUrlToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :short_url, :string
  end
end
