class TestsAllowedUsersController < ApplicationController
  def index
    @allowed_users = TestsAllowedUser.all

    respond_to do |format|
      format.html
      format.json { render json: @allowed_users }
    end
  end

  def show
    @allowed_user = TestsAllowedUser.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @allowed_user }
    end
  end

  def new
    @test_id = params[:test]
    @allowed_users = []
    @users = []
    
    TestsAllowedUser.where(test_id: @test_id).each do |user|
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

  def edit
    @allowed_user = TestsAllowedUser.find(params[:id])
  end

  def create
    users = params[]
    
    raise users.inspect
    
    @allowed_user = TestsAllowedUser.new(params[:allowed_user])

    respond_to do |format|
      if @allowed_user.save
        format.html { redirect_to @allowed_user, notice: 'Allowed user was successfully created.' }
        format.json { render json: @allowed_user, status: :created, location: @allowed_user }
      else
        format.html { render action: "new" }
        format.json { render json: @allowed_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @allowed_user = TestsAllowedUser.find(params[:id])

    respond_to do |format|
      if @allowed_user.update_attributes(params[:allowed_user])
        format.html { redirect_to @allowed_user, notice: 'Allowed user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @allowed_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @allowed_user = TestsAllowedUser.find(params[:id])
    @allowed_user.destroy

    respond_to do |format|
      format.html { redirect_to allowed_users_url }
      format.json { head :no_content }
    end
  end
end
