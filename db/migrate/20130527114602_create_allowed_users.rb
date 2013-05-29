class CreateAllowedUsers < ActiveRecord::Migration
  def change
    create_table :allowed_users do |t|
      t.integer :user_id
      t.integer :test_id
      t.timestamps
    end
  end
end
