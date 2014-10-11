class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :ticket_price

      t.string :location
      t.float :latitude, index: true
      t.float :longitude, index: true

      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
