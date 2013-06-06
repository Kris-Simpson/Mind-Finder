class CreateWhoPasseds < ActiveRecord::Migration
  def change
    create_table :who_passeds do |t|
      t.integer :test_id
      t.integer :user_id
      t.float :rating

      t.timestamps
    end
  end
end
