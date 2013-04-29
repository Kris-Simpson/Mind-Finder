class AddUserIdToTests < ActiveRecord::Migration
  def change
    rename_column :tests, :author, :user_id
  end
end
