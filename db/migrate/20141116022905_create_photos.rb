class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :caption
      t.string :file
      t.references :artist, index: true

      t.timestamps
    end
  end
end
