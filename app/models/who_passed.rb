class WhoPassed < ActiveRecord::Base
  attr_accessible :rating, :test_id, :user_id
  
  belongs_to :test
  
  def get_user
    User.find(self.user_id)
  rescue
    nil
  end
end
