class AddIsSaleableToEvents < ActiveRecord::Migration
  def change
    add_column :events, :is_saleable, :boolean, default: true
  end
end
