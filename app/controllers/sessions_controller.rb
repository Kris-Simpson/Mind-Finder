class SessionsController < ApplicationController
  skip_before_filter :check_user, except: [:destroy]
  
  def new
    
  end
  
  def create
    user = User.find_by_email(params[:email])
    @success = user && user.authenticate(params[:password]) && user.email_confirm
    
    respond_to do |format|      
      if @success
        cookies.permanent[:auth_token] = user.auth_token
        format.html { redirect_to rooms_path }
        format.js
      else
        flash[:alert] = 'Email or password is invalid or you have not verified your email'
        format.html { redirect_to root_url }
        format.js
      end
    end
  end
  
  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url
  end
end
