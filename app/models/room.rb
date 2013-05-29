class Room < ActiveRecord::Base
  attr_accessible :name, :description, :parent_id, :is_main

  has_ancestry

  belongs_to :user
  belongs_to :parent, class_name: "Room"
  has_many :children, class_name: "Room", :foreign_key => "parent_id", dependent: :destroy
  has_many :tests, dependent: :destroy
  has_many :rooms_allowed_users, dependent: :destroy

  validates :name, :presence => true, :length => {
    :in => 3..15
  }
  validates :description, :length => {
    :in => 0..50
  }
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :parent_id, numericality: { only_integer: true }, allow_nil: true
  
  def get_user
    User.find(self.user_id)
  end
end