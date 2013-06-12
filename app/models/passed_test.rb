class PassedTest < ActiveRecord::Base
  attr_accessible :user_id, :test_id, :rating, :updated_at
  
  belongs_to :user
  
  def get_test
    Test.find(self.test_id)
  rescue
    nil
  end
end
