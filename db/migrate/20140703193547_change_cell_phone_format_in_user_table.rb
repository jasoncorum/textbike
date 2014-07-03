class ChangeCellPhoneFormatInUserTable < ActiveRecord::Migration
  def change
  	change_column :users, :phone, :string
  end
end
