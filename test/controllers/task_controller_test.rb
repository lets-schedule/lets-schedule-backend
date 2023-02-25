require "test_helper"

class TaskControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  test "user create task" do
    sign_in users(:james)

    @task = users(:james).tasks.create!(title: "this is a title");

    assert_equal 1, users(:james).tasks.count

  end

  test "user create task from request" do

    post "/users/tokens/sign_up",
      params: { email: "james@james.com", password: "password"}

    json_response = JSON.parse(@response.body)["token"]

    assert_response :success

    post "/task",
      headers: { 'Authorization': "Bearer " + json_response },
      params: { task: { title: "this is a title" } }
    
    assert_response :success
  end

  test "user sign up" do 

    post "/users/tokens/sign_up",
      params: { email: "sample@sample.com", password: "apassword" }

    assert_response :success

  end

  test "user sign in" do
    post "/users/tokens/sign_in",
      params: { email: "jsquie@uw.edu", password: "password"}

    assert_response :success
  end


end
