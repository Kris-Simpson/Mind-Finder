class RoomsController < ApplicationController
  def index
    @rooms = current_user.rooms
  end

  def show
    @room = Room.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @room }
    end
  end

  def new
    @room = Room.new
  end

  def edit
    @room = Room.find(params[:id])
  end

  def create
    @room = current_user.rooms.build(params[:room])

    respond_to do |format|
      format.html { redirect_to rooms_url }
      format.js
    end
  end

  def update
    @room = Room.find(params[:id])

    respond_to do |format|
      if @room.update_attributes(params[:room])
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy

    respond_to do |format|
      format.html { redirect_to rooms_url }
      format.json { head :no_content }
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
