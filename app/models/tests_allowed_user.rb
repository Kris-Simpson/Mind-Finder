class TestsAllowedUser < ActiveRecord::Base
  attr_accessible :user_id, :test_id
  
  belongs_to :test
  
  def its_a?(user)
    self.user_id == user.id
  end
end
