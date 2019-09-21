class CreateUmas < ActiveRecord::Migration[5.2]
  def change
    create_table :umas do |t|
      t.string :horse_id
      t.string :horse_name
      t.string :sex
      t.date :birthday
      t.integer :all
      t.integer :win
      t.integer :second
      t.integer :third
      t.integer :other
      t.integer :money
      t.string :gwin
      t.integer :ghistory

      t.timestamps
    end
  end
end
