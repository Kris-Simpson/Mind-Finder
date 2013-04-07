class UsersController < ApplicationController
  before_filter :user_new, :only => [:new, :index]

  def index
  end

  def new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => t(:notice_signup_success)
    else
      render "index"
    end
  end
  
  private
  
  def user_new
    @user = User.new
  end
end
