class Test < ActiveRecord::Base
  attr_accessible :room_id, :description, :name, :questions_attributes

  belongs_to :room

  has_many :questions, dependent: :destroy

  accepts_nested_attributes_for :questions, reject_if: lambda { |a| a[:question].blank? }, allow_destroy: true

  validates :name, :presence => true, :length => {
    :in => 3...25,
    :too_short => "Test name must have at least %{count} words",
    :too_long  => "Test name must have at most %{count} words"
  }
  validates :description, :length => {
    :in => 0...100,
    :too_short => "Test description must have at least %{count} words",
    :too_long  => "Test description must have at most %{count} words"
  }
end
