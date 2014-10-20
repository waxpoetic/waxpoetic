class AddOpenSourcePackageToReleases < ActiveRecord::Migration
  def change
    add_column :releases, :open_source_package, :string
  end
end
