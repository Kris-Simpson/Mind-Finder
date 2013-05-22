class PassedQuestionsController < ApplicationController
  def new
    @passed_question = PassedQuestion.new
    
    respond_to do |format|
      format.html
      format.json { render json: @passed_question }
    end
  end
end
