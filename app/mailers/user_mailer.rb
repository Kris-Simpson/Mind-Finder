class UserMailer < ActionMailer::Base
  default from: "support@mind-finder.com"
  
  def email_confirmation(user)
    @user = user
    mail(to: user.email, subject: 'Email Confirmation')
  end
  
  def password_reset(user)
    @user = user
    mail(to: user.email, subject: 'Password Reset')
  end
end
