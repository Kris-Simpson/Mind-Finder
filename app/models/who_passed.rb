class WhoPassed < ActiveRecord::Base
  attr_accessible :rating, :test_id, :user_id
  
  belongs_to :test
  
  def get_user
    User.find(self.user_id)
  end
  
  def get_test
    Test.find(self.test_id)
  end
end
