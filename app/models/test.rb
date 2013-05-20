class Test < ActiveRecord::Base
  attr_accessible :room_id, :description, :name, :questions_attributes, :min_shewn_questions, :max_shewn_questions, :time_for_passing, :allowed

  belongs_to :room

  has_many :questions, dependent: :destroy

  accepts_nested_attributes_for :questions, reject_if: lambda { |a| a[:question].blank? }, allow_destroy: true

  validates :name, :presence => true, :length => {
    :in => 3..25
  }
  validates :description, :length => {
    :in => 0...100
  }
  validates :min_shewn_questions, numericality: { only_integer: true }, allow_nil: true
  validates :max_shewn_questions, numericality: { only_integer: true }, allow_nil: true
  
  def is_allowed?
    return questions.map { |question| question.answers.any? }.any?
  end
end
