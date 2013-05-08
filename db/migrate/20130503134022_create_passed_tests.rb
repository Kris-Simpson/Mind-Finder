class CreatePassedTests < ActiveRecord::Migration
  def change
    create_table :passed_tests do |t|
      t.integer :user_id
      t.integer :test_id
      t.integer :rating

      t.timestamps
    end
  end
end
