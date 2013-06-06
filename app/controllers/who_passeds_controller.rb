class WhoPassedsController < ApplicationController
  def index
    @who_passed = WhoPassed.all
    @test = Test.find(params[:test])
  end
end
