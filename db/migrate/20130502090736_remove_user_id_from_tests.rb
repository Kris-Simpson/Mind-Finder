class RemoveUserIdFromTests < ActiveRecord::Migration
  def change
    remove_column :tests, :user_id
  end
end
