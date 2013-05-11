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
    @test = current_user.rooms.first.tests.build(params[:test])

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
end
