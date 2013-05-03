class Room < ActiveRecord::Base
  attr_accessible :name, :description, :parent_id, :is_main

  belongs_to :user
  belongs_to :parent, class_name: "Room"
  has_many :children, class_name: "Room", :foreign_key => "parent_id", dependent: :destroy
  has_many :tests, dependent: :destroy

  validates :name, :presence => true, :length => {
    :in => 3..10,
    :too_short => "must have at least %{count} words",
    :too_long  => "must have at most %{count} words"
  }
  validates :description, :length => {
    :in => 0..50,
    :too_short => "must have at least %{count} words",
    :too_long  => "must have at most %{count} words"
  }
  validates :user_id, :presence => true, :numericality => { :only_integer => true }
  validates :parent_id, :numericality => { :only_integer => true }
end
