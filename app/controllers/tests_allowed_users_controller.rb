class TestsAllowedUsersController < ApplicationController
  def new
    @test = Test.find(params[:test])
    @allowed_users = []
    @users = []
    
    TestsAllowedUser.where(test_id: @test.id).each do |user|
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
