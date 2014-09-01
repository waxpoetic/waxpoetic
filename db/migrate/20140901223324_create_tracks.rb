class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name
      t.references :release, index: true
      t.column :price, :money, index: true

      t.timestamps
    end
  end
end
