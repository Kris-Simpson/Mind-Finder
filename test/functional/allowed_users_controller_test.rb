require 'test_helper'

class AllowedUsersControllerTest < ActionController::TestCase
  setup do
    @allowed_user = allowed_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:allowed_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create allowed_user" do
    assert_difference('AllowedUser.count') do
      post :create, allowed_user: {  }
    end

    assert_redirected_to allowed_user_path(assigns(:allowed_user))
  end

  test "should show allowed_user" do
    get :show, id: @allowed_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @allowed_user
    assert_response :success
  end

  test "should update allowed_user" do
    put :update, id: @allowed_user, allowed_user: {  }
    assert_redirected_to allowed_user_path(assigns(:allowed_user))
  end

  test "should destroy allowed_user" do
    assert_difference('AllowedUser.count', -1) do
      delete :destroy, id: @allowed_user
    end

    assert_redirected_to allowed_users_path
  end
end
