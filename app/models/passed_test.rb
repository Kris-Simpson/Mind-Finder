class PassedTest < ActiveRecord::Base
  attr_accessible :user_id, :test_id, :rating
  
  belongs_to :user
  
  has_many :user_answers
end
