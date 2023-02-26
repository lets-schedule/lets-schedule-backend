require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  # test user sign up success
  test "user sign up" do
    post "/users/tokens/sign_up",
      params: { email: "newuser1@email.com", password: "password" }

    assert_response :success
  end

  # test user sign up account already exists failure
  test "user sign up -- user already exists failure" do
    post "/users/tokens/sign_up",
      params: { email: "jsquie@uw.edu", password: "password" }

    assert_response 422
  end
  # test user sign up no password
  test "user sign up no password error" do
    post "/users/tokens/sign_up",
      params: { email: "newuser2@email.com" }

    assert_response 422
  end

  # test user sign up no email
  test "user sign up no email error" do
    post "/users/tokens/sign_up",
      params: { password: "password" }

    assert_response 422
  end

  # test get user name
  test "get user name" do
    # sign into user_has_name id = 2
    authToken = sign_in_api_user("user_has_name@email.com")

    get "/user",
      headers: { 'Authorization': authToken }

    assert_response :success
    assert_equal users(:user_has_name).name, JSON.parse(@response.body)["name"]
  end

  # test update user name from nil
  test "update user name from nil" do

    authToken = sign_in_api_user("user_no_name@email.com")
    userName = "a new user name!"

    patch "/user",
      headers: { 'Authorization': authToken },
      params: { name: userName }

    assert_response :success
    assert_equal userName, User.find(users(:user_no_name).id).name

  end
  # test update user name not from nil
  test "update user name from existing name" do
    
    authToken = sign_in_api_user("user_has_name@email.com")
    newUserName = "user has a new name"

    patch "/user",
      headers: { 'Authorization': authToken },
      params: { name: newUserName }

    assert_response :success
    assert_equal newUserName, User.find(users(:user_has_name).id).name
  end

  # test user sign in success 
  test "user sign in success" do
    
    post "/users/tokens/sign_in",
      params: { email: "jsquie@uw.edu", password: "password" }

    assert_response :success
  end

  # test user sign in failture -- email DNE
  test "user sign in failure -- email DNE" do

    post "/users/tokens/sign_in",
      params: { email: "thisEmailDoesNotExist@email.com", password: "password"}

    assert_response 400
  end

  # test user sign in failure -- password incorrect
  test "user sign in failure -- password incorrect" do

    post "/users/tokens/sign_in",
      params: { email: "jsquie@uw.edu", password: "incorrectPassword" }

    assert_response 401
  end

  # test user sign in failure -- no password given
  test "user sign in failure -- no password" do

    post "/users/tokens/sign_in",
      params: { email: "jsquie@uw.edu"}

    assert_response 401
  end

  # test user sign in failure -- no args
  test "user sign in failure -- no args" do

    post "/users/tokens/sign_in"

    assert_response 400
  end
  # test user sign in failure -- no email given
  test "user sign in failure -- no email" do

    post "/users/tokens/sign_in",
      params: { password: "password"}

    assert_response 400
  end
  # test user sign in failure -- email incorrect 

  test "user sign in failure -- email incorrect" do

    post "/users/tokens/sign_in",
      params: { email: "jsquie@wsu.edu", password: "password"}

    assert_response 400
  end

  # test refreshing token success 
  test "user refreshes token successfully" do

    post "/users/tokens/sign_in",
      params: { email: "jsquie@uw.edu", password: "password" }

    assert_response :success

    auth_response = JSON.parse(@request.body)["refresh_token"]

    logger.debug auth_response

    post "/users/tokens/refresh",
      headers: { 'Authorization': "Bearer " + auth_response }

    assert_response :success
  end

end
