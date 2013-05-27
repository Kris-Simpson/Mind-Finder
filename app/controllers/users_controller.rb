class UsersController < ApplicationController
  before_filter :user_new, :only => [:new, :index]

  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def create
    @user = User.new(params[:user])
    @user.locale = I18n.locale

    if @user.save
      UserMailer.welcome_email(@user).deliver

      redirect_to root_url, :notice => t(:notice_signup_success)
    else
      render "home/index"
    end
  end
  
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

private
  
  def user_new
    @user = User.new
  end
end