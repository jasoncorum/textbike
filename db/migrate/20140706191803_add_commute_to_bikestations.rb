class AddCommuteToBikestations < ActiveRecord::Migration
  def change
    add_column :bikestations, :commute, :time
  end
end
