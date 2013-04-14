class UsersController < ApplicationController
  before_filter :user_new, :only => [:new, :index]

  def index
  end

  def new
  end

  def u
  end

  def create
    @user = User.new(params[:user])
    @user.locale = I18n.locale

    if @user.save
      UserMailer.welcome_email(@user).deliver
      
      redirect_to root_url, :notice => t(:notice_signup_success)
    else
      render "index"
    end
  end
  
  def change_locale
    locale = params[:locale]
    raise 'unsupported locale' unless ['ru', 'en', 'uk' ].include?(locale)

    if current_user
      current_user.locale = locale
      current_user.save
    end

    I18n.locale = locale

    redirect_to :index
  end

  private
  
  def user_new
    @user = User.new
  end
end