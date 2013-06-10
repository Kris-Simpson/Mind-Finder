class RoomsAllowedUsersController < ApplicationController
  def new
    room_id = params[:room]
    @room = Room.find(room_id)
    @allowed_users = []
    @users = []
    
    RoomsAllowedUser.where(room_id: room_id).each do |user|
      @allowed_users << User.find(user.user_id)
    end
    
    User.where(email_confirm: true).each do |user|
      @users << user unless @allowed_users.include?(user)
    end
    
    @users.delete(current_user)
    
    respond_to do |format|
      format.html
      format.js
    end
  end
end