class AddSomeColumns < ActiveRecord::Migration
  def change
    add_column :tests, :min_shewn_answers, :integer
    add_column :tests, :time_for_passing, :integer
    add_column :questions, :question_type_id, :integer
  end
end
