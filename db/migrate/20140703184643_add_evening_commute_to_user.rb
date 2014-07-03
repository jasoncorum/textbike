class AddEveningCommuteToUser < ActiveRecord::Migration
  def change
    add_column :users, :evening_commute, :time
  end
end
