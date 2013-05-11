class Room < ActiveRecord::Base
  attr_accessible :name, :description, :parent_id, :is_main

  has_ancestry

  belongs_to :user
  belongs_to :parent, class_name: "Room"
  has_many :children, class_name: "Room", :foreign_key => "parent_id", dependent: :destroy
  has_many :tests, dependent: :destroy

  validates :name, :presence => true, :length => {
    :in => 3..15
  }
  validates :description, :length => {
    :in => 0..50
  }
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :parent_id, numericality: { only_integer: true }, allow_nil: true

  def self.get_rooms_tree(room_id)
    @room = Room.find(room_id)
    @path = @room.name + '/'
    
    if @room.parent_id.nil?
      @path
    else

      @parent_room = Room.find(@room.parent_id)
      @parent_room.name
    end
  end
end
