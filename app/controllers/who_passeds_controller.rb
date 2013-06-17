class WhoPassedsController < ApplicationController
  def index
    @test = Test.find_by_id(params[:test])
  end
end