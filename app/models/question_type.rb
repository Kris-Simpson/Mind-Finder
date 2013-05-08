class QuestionType < ActiveRecord::Base
  attr_accessible :description, :name

  belongs_to :question
end
