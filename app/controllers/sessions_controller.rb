class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    
    if user && user.authenticate(params[:password])
      cookies.permanent[:auth_token] = user.auth_token
      redirect_to :workpath
    else
      redirect_to root_url, :alert => t(:alert_email_or_pass_invalid)
    end  
  end
  
  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url
  end
end
