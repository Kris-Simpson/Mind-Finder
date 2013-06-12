class Test < ActiveRecord::Base
  self.per_page = 5
  
  attr_accessible :room_id, :description, :name, :questions_attributes, :min_shewn_questions, :max_shewn_questions, :time_for_passing, :allowed, :max_rating, :allow_repass, :rating_round

  belongs_to :room

  has_many :questions, dependent: :destroy
  has_many :tests_allowed_users, dependent: :destroy
  has_many :who_passeds, dependent: :destroy

  accepts_nested_attributes_for :questions, reject_if: lambda { |a| a[:question].blank? }, allow_destroy: true

  validates_associated :questions

  validates :name, presence: true, length: { in: 3..25 }
  validates :description, length: { in: 0..100 }
  validates :max_rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 5 }
  validates :rating_round, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }, allow_nil: true
  validates :min_shewn_questions, numericality: { only_integer: true }, allow_nil: true
  validates :max_shewn_questions, numericality: { only_integer: true }, allow_nil: true
  
  def self.search(search)
    if search
      where('tests.name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
  
  # def self.to_csv
  #   CSV.generate do |csv|
  #     csv << column_names
  #   end
  # end
  
  def is_allowed?
    return questions.any? { |question| question.answers.any? { |answer| answer.is_right_answer } && question.answers.any? { |answer| !answer.is_right_answer } }
  end
  
  def why_not_allowed?
    unless self.is_allowed?
      no_q   = 'this test without questions.'
      no_a   = 'the questions in this test without answers.'
      no_r_a = 'the questions in this test does not have the right answers.'
      no_w_a = 'the questions in this test does not have the wrong answers.'
      
      unless questions.any?
        return no_q
      end
      
      unless questions.any? { |question| question.answers.any? }
        return no_a
      end
      
      unless questions.any? { |question| question.answers.any? { |answer| answer.is_right_answer } }
        return no_r_a
      end
      
      unless questions.any? { |question| question.answers.any? { |answer| answer.is_right_answer } && question.answers.any? { |answer| !answer.is_right_answer } }
        return no_w_a
      end
    end
  end
  
  def allowed_users
    return tests_allowed_users.count == 0 ? 'all' : tests_allowed_users.count
  end
  
  def get_room
    Room.find(self.room_id)
  end
end
