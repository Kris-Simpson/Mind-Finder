class AddColumnsToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :name, :string
    add_column :rooms, :description, :string
    add_column :rooms, :user_id, :string
  end
end
