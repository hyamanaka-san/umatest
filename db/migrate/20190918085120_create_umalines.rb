class CreateUmalines < ActiveRecord::Migration[5.2]
  def change
    create_table :umalines do |t|
      t.string :uma_id
      t.string :ml
      t.string :ml2
      t.string :ml3_1

      t.timestamps
    end
  end
end
