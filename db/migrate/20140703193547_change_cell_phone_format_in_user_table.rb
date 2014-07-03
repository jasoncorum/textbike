class ChangeCellPhoneFormatInUserTable < ActiveRecord::Migration
  def change
  	change_column :users, :phone, :phone
  end
end
