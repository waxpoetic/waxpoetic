class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.string :name
      t.references :artist, index: true
      t.datetime :released_on
      t.string :cover
      t.text :description
      t.string :catalog_number

      t.timestamps
    end
  end
end
