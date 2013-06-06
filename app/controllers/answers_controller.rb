class AnswersController < ApplicationController
  def index
    @answers = Answer.all

    respond_to do |format|
      format.html
      format.json { render json: @answers }
    end
  end

  def show
    @answer = Answer.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @answer }
    end
  end

  def new
    @answer = Answer.new

    respond_to do |format|
      format.html
      format.json { render json: @answer }
    end
  end

  def edit
    @answer = Answer.find(params[:id])
  end

  def create
    @answer = Answer.new(params[:answer])

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer, notice: 'Answer was successfully created.' }
        format.json { render json: @answer, status: :created, location: @answer }
      else
        format.html { render action: "new" }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @answer = Answer.find(params[:id])

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to answers_url }
      format.json { head :no_content }
    end
  end
end