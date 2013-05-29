class RoomsAllowedUser < ActiveRecord::Base
  attr_accessible :user_id, :room_id
  
  belongs_to :room
  
  def its_a?(user)
    self.user_id == user.id
  end
end
