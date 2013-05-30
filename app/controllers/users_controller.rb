class UsersController < ApplicationController
  before_filter :user_new, :only => [:new, :index]
  
  helper_method :sort_column, :sort_direction

  def index
    @users = User.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(per_page: 15, page: params[:page])

    respond_to do |format|
      format.html
      format.js
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
  
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end