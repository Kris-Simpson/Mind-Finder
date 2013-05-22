class PassedQuestion < ActiveRecord::Base
  attr_accessible :user_id, :question_id, :passed
  
  belongs_to :passed_test
end
