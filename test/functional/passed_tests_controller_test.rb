require 'test_helper'

class PassedTestsControllerTest < ActionController::TestCase
  setup do
    @passed_test = passed_tests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:passed_tests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create passed_test" do
    assert_difference('PassedTest.count') do
      post :create, passed_test: {  }
    end

    assert_redirected_to passed_test_path(assigns(:passed_test))
  end

  test "should show passed_test" do
    get :show, id: @passed_test
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @passed_test
    assert_response :success
  end

  test "should update passed_test" do
    put :update, id: @passed_test, passed_test: {  }
    assert_redirected_to passed_test_path(assigns(:passed_test))
  end

  test "should destroy passed_test" do
    assert_difference('PassedTest.count', -1) do
      delete :destroy, id: @passed_test
    end

    assert_redirected_to passed_tests_path
  end
end
