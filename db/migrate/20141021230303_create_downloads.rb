class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.references :order, index: true

      t.timestamps
    end
  end
end
