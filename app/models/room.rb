class Room < ActiveRecord::Base
  attr_accessible :name, :description

  # has_many :rooms, :class_name => "Room",
  #   :foreign_key => "manager_id"
  # belongs_to :manager, :class_name => "Employee"
  belongs_to :user

  validates :name, :presence => true, :length => {
    :in => 3...10,
    :too_short => "must have at least %{count} words",
    :too_long  => "must have at most %{count} words"
  }
  validates :description, :length => {
    :in => 0...100,
    :too_short => "must have at least %{count} words",
    :too_long  => "must have at most %{count} words"
  }
  validates :user_id, :presence => true, :numericality => { :only_integer => true }
end
