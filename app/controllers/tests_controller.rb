class TestsController < ApplicationController
  def index
    @tests = current_user.tests
  end

  def show
    @test = Test.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @test }
    end
  end

  def new
    @test = Test.new
  end

  # GET /tests/1/edit
  def edit
    @test = current_user.tests.find(params[:id])
  end

  # POST /tests
  # POST /tests.json
  def create
    @test = current_user.rooms.find(params[:test][:room_id]).tests.build(params[:test])

    @test.allowed = @test.questions.any? ? true : false
    @test.save

    respond_to do |format|
      if @test.valid?
        format.html { redirect_to tests_path, notice: 'Test was successfully created.' }
        format.json { render json: @test, status: :created, location: @test }
      else
        format.html { render action: "new" }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tests/1
  # PUT /tests/1.json
  def update
    @test = current_user.tests.find(params[:id])
    @test.update_attributes(params[:test])
    @test.update_attribute(:allowed, @test.questions.any? ? true : false)

    respond_to do |format|
      if @test.valid?
        format.html { redirect_to tests_path, notice: 'Test was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    @test = current_user.tests.find(params[:id])
    @test.destroy

    respond_to do |format|
      format.html { redirect_to tests_url }
      format.js
    end
  end

private

  def get_questions(test)
    max_q = test.max_shewn_questions
    min_q = test.min_shewn_questions
    blank_questions = test.questions.select { |question| question.answers.blank? }
    questions = []
    num = nil

    if max_q.nil? && min_q.nil?      
      num = test.questions.count - blank_questions.count
    else
      max = max_q.nil? ? test.questions.count - blank_questions.count : max_q - blank_questions.count
      min = min_q.nil? ? 1 : min_q
      num = Random.rand(min..max)
    end

    num.times do
      loop do
        question = test.questions[Random.rand(0..test.questions.count - 1)]

        next if question.answers.blank?

        unless questions.include?(question)
          questions << question
          break
        end
      end
    end

    questions
  end

  def get_answers(question)
    type = question.question_type_id
    max_a = question.max_shewn_answers
    min_a = question.min_shewn_answers
    right_answers = question.answers.select { |answer| answer.is_right_answer }
    answers = []
    num = nil

    if max_a.nil? && min_a.nil?
      num = question.answers.count
    else
      max = max_a.nil? ? question.answers.count : max_a
      min = min_a.nil? ? 1 : min_a
      num = Random.rand(min..max)
    end

    num.times do
      loop do
        answer = question.answers[Random.rand(0..question.answers.count - 1)]
        unless answers.include?(answer)
          answers << answer
          break
        end
      end
    end

    unless answers.any?(&:is_right_answer)
      right_answers.each do |r_answer|
        loop do
          index = Random.rand(0..answers.count - 1)

          unless answers[index].is_right_answer
            answers[index] = r_answer
            break
          end
        end
      end
    end

    answers
  end

  helper_method :get_questions, :get_answers
end