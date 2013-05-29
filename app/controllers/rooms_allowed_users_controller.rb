class RoomsAllowedUsersController < ApplicationController
  def new
    @room_id = params[:room]
    @allowed_users = []
    @users = []
    
    RoomsAllowedUser.where(room_id: @room_id).each do |user|
      @allowed_users << User.find(user.user_id)
    end
    
    User.all.each do |user|
      @users << user unless @allowed_users.include?(user)
    end
    
    @users.delete(current_user)
    
    respond_to do |format|
      format.html
      format.json { render json: @allowed_user }
    end
  end
end
