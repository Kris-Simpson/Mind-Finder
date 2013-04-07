class UserMailer < ActionMailer::Base
  default from: "support@mind-finder.herokuapp.com"
  
  def welcome_email(user)
    @user = user
    @url  = "http://mind-finder.herokuapp.com"
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end
end
