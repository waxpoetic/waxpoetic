class AddPackageToRelease < ActiveRecord::Migration
  def change
    add_column :releases, :package, :string
  end
end
