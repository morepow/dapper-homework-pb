class AddIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :id, :primary_key
  end
end
