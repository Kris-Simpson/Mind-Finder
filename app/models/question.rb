class Question < ActiveRecord::Base
  attr_accessible :question, :test_id

  belongs_to :test

  has_many :answers

  validates :question, presence: true, :length => {
    :in => 6...100,
    :too_short => "must have at least %{count} words",
    :too_long  => "must have at most %{count} words"
  }
  validates :test_id, :presence => true, :numericality => { :only_integer => true }
end
