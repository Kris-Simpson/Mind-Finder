class RoomsController < ApplicationController
  def index
    @rooms = current_user.rooms.search(params[:search]).order(:created_at).page(params[:page])
  end

  def show
    @room = Room.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @room = Room.new
  end

  def edit
    @room = Room.find(params[:id])
    @success = current_user.rooms.include?(@room)

    respond_to do |format|
      format.html { redirect_to rooms_url }
      format.js
    end
  end

  def create
    @room = current_user.rooms.create(params[:room])

    respond_to do |format|
      if @room.valid?
        format.html { redirect_to rooms_url }
        format.js
      else
        format.html
        format.js
      end
    end
  end

  def update
    @room = current_user.rooms.find(params[:id])

    respond_to do |format|
      if @room.update_attributes(params[:room])
        format.html { redirect_to rooms_url }
        format.js
      else
        format.html { render action: "edit" }
        format.js
      end
    end
  end

  def destroy
    @room = current_user.rooms.find(params[:id])
    @room.destroy

    respond_to do |format|
      format.html { redirect_to rooms_url }
      format.js
    end
  end

  
  def user_allowed
    new_users = params[:new_users][:id] if params[:new_users]
    deleted_users = params[:deleted_users][:id] if params[:deleted_users]
    room = Room.find_by_id(params[:room_id])
    
    unless deleted_users.nil?
      deleted_users.each do |user|
        RoomsAllowedUser.where(user_id: user, room_id: room.id).delete_all
        room.tests.each do |test|
          TestsAllowedUser.where(user_id: user, test_id: test.id).delete_all
        end
      end
    end

    unless new_users.nil?
      new_users.each do |user|
        allowed_user = RoomsAllowedUser.create(user_id: user, room_id: room.id)
        room.tests.each do |test|
          TestsAllowedUser.create(user_id: user, test_id: test.id)
        end
      end
    end
    
    respond_to do |format|
      format.html { redirect_to rooms_path }
      format.js
    end
  end
end