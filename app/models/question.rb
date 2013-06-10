class Question < ActiveRecord::Base
  attr_accessible :question, :test_id, :answers_attributes, :question_type_id, :min_shewn_answers, :max_shewn_answers, :explanation

  belongs_to :test

  has_one :question_type
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers, reject_if: lambda { |a| a[:answer].blank? }, allow_destroy: true

  validates_associated :answers

  validates :question, presence: true, length: { in: 6..100 }
  validates :explanation, length: { in: 0...100 }
  validates :min_shewn_answers, numericality: { only_integer: true }, allow_nil: true
  validates :max_shewn_answers, numericality: { only_integer: true }, allow_nil: true
end
