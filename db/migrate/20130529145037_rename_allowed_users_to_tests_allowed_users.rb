class RenameAllowedUsersToTestsAllowedUsers < ActiveRecord::Migration
  def change
    rename_table :allowed_users, :tests_allowed_users
  end
end
