class PasswordResetsController < ApplicationController
  skip_before_filter :check_user
  
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, notice: 'Email sent with password reset instructions'
  end
  
  def edit
    @user = User.find_by_reset_password_token!(params[:id])
  end
  
  def update
    @user = User.find_by_reset_password_token!(params[:id])

    respond_to do |format|
      if @user.password_reset_sent_at < 2.hours.ago
        flash[:alert] = 'Password reset has expired'
        format.html { redirect_to new_password_reset_path }
        format.js
      elsif @user.update_attributes(params[:user])
        flash[:notice] = 'Password has been successfully reset'
        format.html { redirect_to root_url }
        format.js
      else
        format.html
        format.js
      end
    end
  end
end
