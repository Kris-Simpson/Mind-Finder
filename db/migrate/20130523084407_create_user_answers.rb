class CreateUserAnswers < ActiveRecord::Migration
  def change
    create_table :user_answers do |t|
      t.integer :user_id
      t.integer :test_id
      t.timestamps
    end
  end
end
