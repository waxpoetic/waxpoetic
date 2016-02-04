class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :artist, index: true, foreign_key: true
      t.string :name
      t.string :location
      t.datetime :starts_at, index: true, null: false
      t.string :facebook_id, index: true, unique: true, null: false

      t.timestamps null: false
    end
  end
end
