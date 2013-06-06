class HomeController < ApplicationController
  skip_before_filter :check_user
  
  def index
    redirect_to :tests if current_user
  end
end
