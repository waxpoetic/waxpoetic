class RenameAllImageFieldsToImage < ActiveRecord::Migration
  def change
    rename_column :artists, :avatar, :image
    rename_column :releases, :cover, :image
  end
end
