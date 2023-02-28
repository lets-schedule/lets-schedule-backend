class UserController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false  
  before_action :authenticate_devise_api_token!

  def index

    render json: { name: current_devise_api_user.name }, status: :ok

  end

  def update

    if current_devise_api_token.resource_owner.update(user_params)
      render json: current_devise_api_user, status: :ok
    else
      render json: { errors: current_devise_api_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name)
  end

end
