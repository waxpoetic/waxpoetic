class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.text :bio
      t.string :avatar
      t.integer :facebook_page_id

      t.timestamps
    end
  end
end
