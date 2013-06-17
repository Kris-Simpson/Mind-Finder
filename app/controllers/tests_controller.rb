require 'csv'

class TestsController < ApplicationController
  def index
    @tests = current_user.tests.includes(:room).search(params[:search]).order(:created_at).page(params[:page])
  end

  def show
    @test = Test.find_by_id(params[:id])

    respond_to do |format|
      format.html
      # format.csv { send_data @test.to_csv }
      format.json { render json: @test }
    end
  end

  def new
    @test = Test.new
  end
  
  def edit
    @test = Test.find(params[:id])
    @success = current_user.tests.include?(@test)
  end
  
  def create
    @test = current_user.rooms.find(params[:test][:room_id]).tests.create(params[:test])
    @test.rating_round = 0 if params[:test][:rating_round].blank?
    @test.time_for_passing = nil if params[:test][:time_for_passing] == '00:00:00'

    respond_to do |format|
      if @test.valid?
        format.html { redirect_to tests_path, notice: 'Test was successfully created.' }
        format.js
      else
        format.html { render action: "new" }
        format.js
      end
    end
  end

  def update
    @test = current_user.tests.find(params[:id])

    respond_to do |format|
      if @test.update_attributes(params[:test])
        @test.update_attribute(:rating_round, 0) if params[:test][:rating_round].blank?
        @test.update_attribute(:time_for_passing, nil) if params[:test][:time_for_passing] == '00:00:00'
        format.html { redirect_to tests_path, notice: 'Test was successfully updated.' }
        format.js
      else
        format.html { render action: "edit" }
        format.js
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
    @answers = Answer.find(params[:answers][:id]) if params[:answers]
    be_answered = []
    @wrong_answers = []

    unless @answers.nil?
      @all_questions.each do |question|
        @answers.each do |answer|
          be_answered << question if question.answers.include?(answer) && !be_answered.include?(question)
        end
      end
    end
    
    @all_questions.each do |question|
      @wrong_answers << question unless be_answered.include?(question)
    end

    unless be_answered.nil?
      be_answered.each do |question|
        question_wrong_answers = []
        
        question.answers.each do |answer|
          question_wrong_answers << answer unless answer.is_right_answer
        end
        
        @answers.each do |answer|
          @wrong_answers << question if question_wrong_answers.include?(answer)
        end
      end
    end
    
    @rating = calculate_rating(@test.max_rating, @all_questions.count, be_answered.blank? ? nil : be_answered.count - (@wrong_answers.nil? ? 0 : @wrong_answers.count))
    passed_test = PassedTest.where(user_id: params[:user_id], test_id: @test.id)
    who_passed = WhoPassed.new(test_id: @test.id, user_id: params[:user_id], rating: @rating)
    if passed_test.blank?
      PassedTest.create(user_id: params[:user_id], test_id: @test.id, rating: @rating, updated_at: Time.zone.now)
      who_passed.save
    else
      passed_test.update_all(rating: @rating)
      who_passed.save
    end
  end
  
  def user_allowed
    new_users = params[:new_users][:id] if params[:new_users]
    deleted_users = params[:deleted_users][:id] if params[:deleted_users]
    test_id = params[:test_id] if params[:test_id]
    
    unless deleted_users.nil?
      deleted_users.each do |user|
        TestsAllowedUser.where(user_id: user, test_id: test_id).delete_all
      end
    end

    unless new_users.nil?
      new_users.each do |user|
        allowed_user = TestsAllowedUser.create(user_id: user, test_id: test_id)
      end
    end
    
    respond_to do |format|
      format.html { redirect_to tests_path }
      format.js
    end
  end

private

  def calculate_rating(max_rating, questions_count, answered_count)
    answered_count.nil? ? 0 : Float(max_rating) / questions_count * answered_count
  end

  def get_questions(test) #get random valid questions
    max_q = test.max_shewn_questions #max questions
    min_q = test.min_shewn_questions > max_q ? max_q : test.min_shewn_questions #min questions, can not be more than max questions

    blank_questions = test.questions.select { |question| !question.answers.any? { |answer| answer.is_right_answer } } #questions without right answers
    valid_questions = []
    num = nil

    #getting the Random num of questions
    if max_q.zero? && min_q.zero?      
      num = test.questions.count - blank_questions.count
    else
      max = max_q.zero? ? test.questions.count - blank_questions.count : (max_q > test.questions.count ? test.questions.count : max_q) - blank_questions.count
      min = min_q.zero? ? 1 : (min_q > test.questions.count ? test.questions.count : min_q)
      num = Random.rand(min..max)
    end
    
    num.times do
      loop do
        question = test.questions[Random.rand(0..test.questions.count - 1)]

        next if blank_questions.include?(question)

        unless valid_questions.include?(question)
          valid_questions << question
          break
        end
      end
    end
    
    valid_questions
  end

  def get_answers(question) #get random valid answers
    max_a = question.max_shewn_answers #max answers
    min_a = question.min_shewn_answers > max_a ? max_a : question.min_shewn_answers #min answers
    right_answers = question.answers.select { |answer| answer.is_right_answer }
    answers = []
    num = nil

    if max_a.zero? && min_a.zero?
      num = question.answers.count
    else
      max = max_a.zero? ? question.answers.count : (max_a > question.answers.count ? question.answers.count : max_a)
      min = min_a.zero? ? 1 : (min_a > question.answers.count ? question.answers.count : min_a)
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