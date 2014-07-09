class RenameBikestationsToCommutes < ActiveRecord::Migration
  def change
  	rename_table :bikestations, :commutes 
  end
end
