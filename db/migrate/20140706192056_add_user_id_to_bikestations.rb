class AddUserIdToBikestations < ActiveRecord::Migration
  def change
    add_column :bikestations, :user_id, :integer
    add_index :bikestations, :user_id
  end
end
