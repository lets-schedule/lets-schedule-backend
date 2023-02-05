require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  #   test "the truth" do
  # assert true
  # end
  test "user should have name and email" do
    user = User.new
    assert_not user.save, "Saved user without name and email"
  end

  test "user create" do
    user = User.new(name: "james", email: "jsquie@uw.edu")
    assert user.save
  end

  test "get all users" do
    get user_url(User.first)
    assert_response :success
  end

end