ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # Helper to sign in user -- note that password is assumed to be "password"
  def sign_in_api_user(user_email)
    post "/users/tokens/sign_in",
      params: { email: user_email, password: "password"}

    assert_response :success
    auth_reponse = "Bearer " + JSON.parse(@response.body)["token"]

    auth_reponse

  end
end
