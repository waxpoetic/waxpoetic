class RenamePackageToFileOnReleases < ActiveRecord::Migration
  def change
    rename_column :releases, :package, :file
  end
end
