class RoomsController < ApplicationController
  def index
    @rooms = current_user.rooms
  end

  def show
    @room = current_user.rooms.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @room = Room.new
  end

  def edit
    @room = current_user.rooms.find(params[:id])

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
        format.js { render json: @room.errors, status: :unprocessable_entity }
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

  private

  def get_rooms
    rooms = []
    parent_rooms = []
    children_rooms = []

    current_user.rooms.each { |room|
      if room.parent.nil?
        parent_rooms << room
      elsif !room.parent.nil?
        children_rooms << room
      end
    }

    parent_rooms.each { |room|
      
    }

    return children_rooms.length + parent_rooms.length
  end

  def get_tests
    @tests = nil
  end

  helper_method :get_rooms, :get_tests
end
