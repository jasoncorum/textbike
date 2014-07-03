class AddMorningCommuteToUser < ActiveRecord::Migration
  def change
    add_column :users, :morning_commute, :time
  end
end
