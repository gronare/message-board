require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "should create new user" do
    post register_url, params: { user: { name: 'Test User', email: 'test_user', password: 'test_password' }}
    assert_response :success
  end
end
