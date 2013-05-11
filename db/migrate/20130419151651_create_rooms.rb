class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :description
      t.integer :user_id
      t.string :ancestry
      t.boolean :is_main

      t.timestamps
    end
  end
end
