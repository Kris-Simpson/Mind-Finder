class User < ActiveRecord::Base
  before_create { generate_token(:auth_token) }

  has_secure_password

  attr_accessible :email, :password, :password_confirmation, :locale

  has_many :rooms
  has_many :tests
  
  validates_associated :rooms, :tests

  validates :email, :presence => true, :uniqueness => { :case_sensitive => false }
  validates :password, :length => {
    :in => 6..20,
    :too_short => "must have at least %{count} words",
    :too_long  => "must have at most %{count} words"
  }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
