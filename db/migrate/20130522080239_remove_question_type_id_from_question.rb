class RemoveQuestionTypeIdFromQuestion < ActiveRecord::Migration
  def change
    remove_column :questions, :question_type_id
  end
end
