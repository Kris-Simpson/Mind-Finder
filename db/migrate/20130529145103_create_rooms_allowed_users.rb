class CreateRoomsAllowedUsers < ActiveRecord::Migration
  def change
    create_table :rooms_allowed_users do |t|
      t.integer :user_id
      t.integer :room_id
      t.timestamps
    end
  end
end
