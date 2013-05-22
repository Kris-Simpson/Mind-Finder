class PassedTest < ActiveRecord::Base
  attr_accessible :rating, :test_id, :user_id
  
  belongs_to :user
  
  has_many :passed_questions
end
