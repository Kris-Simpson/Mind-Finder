class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :password, :password_confirmation

  validates :email, :presence => true, :uniqueness => { :case_sensitive => false }
  validates :password, :length => {
    :in => 6..20,
    :too_short => "must have at least %{count} words",
    :too_long  => "must have at most %{count} words"
  }
end
