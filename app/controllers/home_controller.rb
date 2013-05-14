class HomeController < ApplicationController
  def index
    redirect_to :tests if current_user
    @user = User.new
  end
end
