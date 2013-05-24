class UserAnswer < ActiveRecord::Base
  attr_accessible :user_id, :test_id
  
  belongs_to :passed_test
end
