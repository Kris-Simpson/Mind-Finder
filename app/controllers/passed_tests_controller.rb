class PassedTestsController < ApplicationController
  def index
    @passed_tests = current_user.passed_tests.all

    respond_to do |format|
      format.html
      format.json { render json: @passed_tests }
    end
  end

  def show
    @passed_test = PassedTest.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @passed_test }
    end
  end
end