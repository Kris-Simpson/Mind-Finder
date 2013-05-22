class CreatePassedQuestions < ActiveRecord::Migration
  def change
    create_table :passed_questions do |t|
      t.integer :user_id
      t.integer :question_id
      t.boolean :passed
      t.timestamps
    end
  end
end
