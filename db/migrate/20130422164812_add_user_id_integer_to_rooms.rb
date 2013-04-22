class AddUserIdIntegerToRooms < ActiveRecord::Migration
  def change
    remove_column :rooms, :user_id
    add_column :rooms, :user_id, :integer
  end
end
