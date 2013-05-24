class PassedTestsController < ApplicationController
  def index
    @passed_tests = PassedTest.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @passed_tests }
    end
  end

  def show
    @passed_test = PassedTest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @passed_test }
    end
  end

  def new
    @passed_test = PassedTest.new

    respond_to do |format|
      format.html
      format.json { render json: @passed_test }
    end
  end

  def edit
    @passed_test = PassedTest.find(params[:id])
  end

  def create
    raise params[:passed_test].inspect
    @passed_test = PassedTest.new(params[:passed_test])

    respond_to do |format|
      if @passed_test.save
        format.html { redirect_to @passed_test, notice: 'Passed test was successfully created.' }
        format.json { render json: @passed_test, status: :created, location: @passed_test }
      else
        format.html { render action: "new" }
        format.json { render json: @passed_test.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @passed_test = PassedTest.find(params[:id])

    respond_to do |format|
      if @passed_test.update_attributes(params[:passed_test])
        format.html { redirect_to @passed_test, notice: 'Passed test was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @passed_test.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @passed_test = PassedTest.find(params[:id])
    @passed_test.destroy

    respond_to do |format|
      format.html { redirect_to passed_tests_url }
      format.json { head :no_content }
    end
  end
end