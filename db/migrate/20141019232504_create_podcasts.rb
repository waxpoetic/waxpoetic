class CreatePodcasts < ActiveRecord::Migration
  def change
    create_table :podcasts do |t|
      t.string :name
      t.string :enclosure
      t.text :description
      t.integer :number, index: true, unique: true

      t.timestamps
    end
  end
end
