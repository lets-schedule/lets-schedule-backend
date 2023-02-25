class UserController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false  
  before_action :authenticate_devise_api_token!


end
