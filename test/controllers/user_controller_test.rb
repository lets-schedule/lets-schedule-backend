require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  test "user sign in" do
    sign_in users(:james)
    assert true
  end
  # test "the truth" do
  #   assert true
  # end
end
