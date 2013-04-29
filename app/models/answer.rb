class Answer < ActiveRecord::Base
  attr_accessible :answer, :is_right_answer, :question_id

  belongs_to :question

  validates :answer, :presence => true, :length => {
    :in => 3...50,
    :too_short => "Answer must have at least %{count} words",
    :too_long  => "Answer must have at most %{count} words"
  }
  validates :question_id, :presence => true, :numericality => { :only_integer => true }
end
