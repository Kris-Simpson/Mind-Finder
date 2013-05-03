class AddIsMainToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :is_main, :boolean
  end
end
