class CreateBikestations < ActiveRecord::Migration
  def change
    create_table :bikestations do |t|
      t.integer :nb_bikes

      t.timestamps
    end
  end
end
