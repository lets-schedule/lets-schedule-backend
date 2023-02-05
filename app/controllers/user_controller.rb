class UserController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  def show
    @user = User.find(params[:id])
    render json: @user, status: :ok
  end

  def index
    users = User.all
    render json: users, status: :ok
  end

  def create
    user = User.create!(user_params)
    render json: user, status: :ok
  end
  
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
