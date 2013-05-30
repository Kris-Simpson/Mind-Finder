class Test < ActiveRecord::Base
  attr_accessible :room_id, :description, :name, :questions_attributes, :min_shewn_questions, :max_shewn_questions, :time_for_passing, :allowed, :max_rating, :allow_repass, :rating_round

  belongs_to :room

  has_many :questions, dependent: :destroy
  has_many :tests_allowed_users, dependent: :destroy

  accepts_nested_attributes_for :questions, reject_if: lambda { |a| a[:question].blank? }, allow_destroy: true

  validates :name, :presence => true, :length => {
    :in => 3..25
  }
  validates :description, :length => {
    in: 0...100,
  }
  validates :max_rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 5 }
  validates :rating_round, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }, allow_nil: true
  validates :min_shewn_questions, numericality: { only_integer: true }, allow_nil: true
  validates :max_shewn_questions, numericality: { only_integer: true }, allow_nil: true
  
  def is_allowed?
    return questions.any? { |question| question.answers.any? }
  end
  
  def get_room
    Room.find(self.room_id)
  end
end
