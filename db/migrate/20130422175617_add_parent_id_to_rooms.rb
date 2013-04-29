class AddParentIdToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :parent, :integer
  end
end
