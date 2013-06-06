class UsersController < ApplicationController
  before_filter :user_new, only: [:new, :index]
  before_filter :skip_password_attribute, only: :update
  skip_before_filter :check_user, except: [:index, :show]
  
  helper_method :sort_column, :sort_direction

  def index
    @users = User.where('email_confirm = ?', true).search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(per_page: 15, page: params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def new
    @user = User.new
  end
  
  def edit
    if current_user
      @user = current_user
    else
      @user = User.find_by_email_confirmation_token!(params[:id])
      flash[:notice] = 'Thanks you for signing up'
    end
  end

  def create
    @user = User.new(params[:user])
    @user.email.downcase!
    @user.locale = I18n.locale

    respond_to do |format|
      if @user.save
        @user.send_email_confirmation
        flash[:notice] = t(:notice_signup_success)
        format.html { redirect_to root_url }
        format.js
      else
        format.html
        format.js
      end
    end
  end
  
  def update
    @user = User.find(params[:id])
    
    @success = @user.update_attributes(params[:user])
    
    respond_to do |format|
      if @success
        @user.activate unless @user.activated?
        format.html { redirect_to root_url }
        format.js
      else
        format.html { render action: "edit" }
        format.js
      end
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

private
  
  def user_new
    @user = User.new
  end
  
  def skip_password_attribute
    if params[:password].blank? && params[:password_confirmation].blank?
      params.except!(:password, :password_confirmation)
    end
  end
  
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end