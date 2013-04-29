class Test < ActiveRecord::Base
  attr_accessible :user_id, :description, :name

  belongs_to :user

  has_many :questions

  validates :user_id, :presence => true, :numericality => { :only_integer => true }
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
