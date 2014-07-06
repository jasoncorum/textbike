class AddNameToBikestations < ActiveRecord::Migration
  def change
    add_column :bikestations, :station_name, :string
  end
end
