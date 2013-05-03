class AddRoomIdToTests < ActiveRecord::Migration
  def change
    add_column :tests, :room_id, :integer
  end
end
