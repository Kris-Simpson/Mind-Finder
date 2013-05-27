class TestsController < ApplicationController
  def index
    @tests = current_user.tests.includes(:room)
  end

  def show
    @test = Test.find(params[:id])
    @passed_test = PassedTest.new

    respond_to do |format|
      format.html
      format.json { render json: @test }
    end
  end

  def new
    @test = Test.new
  end
  
  def edit
    @test = current_user.tests.find(params[:id])
  end
  
  def create
    @test = current_user.rooms.find(params[:test][:room_id]).tests.create(params[:test])

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

  def update
    @test = current_user.tests.find(params[:id])

    respond_to do |format|
      if @test.update_attributes(params[:test])
        format.html { redirect_to tests_path, notice: 'Test was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @test = current_user.tests.find(params[:id])
    @test.destroy

    respond_to do |format|
      format.html { redirect_to tests_url }
      format.js
    end
  end
  
  def test_passed
    @test = Test.find(params[:test_id])
    @all_questions = Question.find(params[:questions][:id])
    answers = Answer.find(params[:answers][:id]) if params[:answers]
    be_answered = []
    @wrong_answers = []
    
    unless answers.nil?
      @all_questions.each do |question|
        answers.each do |answer|
          be_answered << question if question.answers.include?(answer) && !be_answered.include?(question)
        end
      end
    end
    
    @all_questions.each do |question|
      @wrong_answers << question unless be_answered.include?(question)
    end

    be_answered.each do |question|
      question_wrong_answers = []
      
      question.answers.each do |answer|
        question_wrong_answers << answer unless answer.is_right_answer
      end
      
      answers.each do |answer|
        @wrong_answers << question if question_wrong_answers.include?(answer)
      end
    end
    
    passed_test = PassedTest.create(user_id: params[:user_id], test_id: @test.id)
  end

private

  def get_questions(test)
    max_q = test.max_shewn_questions
    min_q = test.min_shewn_questions
    blank_questions = test.questions.select { |question| question.answers.blank? }
    questions = []
    num = nil

    if max_q.zero? && min_q.zero?      
      num = test.questions.count - blank_questions.count
    else
      max = max_q.zero? ? test.questions.count - blank_questions.count : max_q - blank_questions.count
      min = min_q.zero? ? 1 : min_q
      num = Random.rand(min..max)
    end

    num.times do
      loop do        
        question = test.questions[Random.rand(0..test.questions.count - 1).to_i]

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
    max_a = question.max_shewn_answers
    min_a = question.min_shewn_answers
    right_answers = question.answers.select { |answer| answer.is_right_answer }
    answers = []
    num = nil

    if max_a.zero? && min_a.zero?
      num = question.answers.count
    else
      max = max_a.zero? ? question.answers.count : max_a
      min = min_a.zero? ? 1 : min_a
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

    unless answers.select { |a| a.is_right_answer }.count == right_answers.count
      right_answers.delete_if { |r_answer| answers.include?(r_answer) }

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