class AddSlugToArtistsAndReleases < ActiveRecord::Migration
  def change
    add_column :artists, :slug, :string, index: true
    add_column :releases, :slug, :string, index: true
  end
end
