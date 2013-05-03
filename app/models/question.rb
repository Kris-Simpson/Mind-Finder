class Question < ActiveRecord::Base
  attr_accessible :question, :test_id, :answers_attributes

  belongs_to :test

  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers, reject_if: lambda { |a| a[:answer].blank? }, allow_destroy: true

  validates :question, presence: true, :length => {
    :in => 6...100,
    :too_short => "must have at least %{count} words",
    :too_long  => "must have at most %{count} words"
  }
end
