class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :password, :password_confirmation, :locale, :first_name, :last_name, :email_confirm

  has_many :rooms, dependent: :destroy
  has_many :tests, through: :rooms
  has_many :passed_tests, dependent: :destroy
  
  validates_associated :rooms, :tests, :passed_tests

  validates :first_name, length: { in: 0..20 }
  validates :last_name, length: { in: 0..20 }
  validates :email, :presence => true, :uniqueness => { :case_sensitive => false }
  validates :password, length: { :in => 6..20, allow_blank: true }, presence: true, on: :create

  before_create { generate_token(:auth_token) }

  def self.search(search)
    if search
      where('first_name LIKE ? OR last_name LIKE ? OR email LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
  
  def activate
    self.update_column(:email_confirm, true)
  end

  def activated?
    email_confirm
  end
  
  def send_password_reset
    generate_token(:reset_password_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  def send_email_confirmation
    generate_token(:email_confirmation_token)
    save!
    UserMailer.email_confirmation(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  def get_full_name
    self.first_name.blank? || self.last_name.blank? ? self.email : self.first_name.capitalize + ' ' + self.last_name.capitalize
  end
end
