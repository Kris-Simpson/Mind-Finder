class AddParentIdToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :parent_id, :integer
  end
end
