class AddAwsCredentialsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :aws, :hstore
  end
end
