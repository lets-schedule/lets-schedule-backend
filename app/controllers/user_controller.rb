class UserController < ApplicationController

  # GET /user/{id}
  # GET /user/{availability}
  def show
    if params[:id]
      @user = User.find(params[:id])
      render json: @user, status: :ok
    else
      @user = Task.where(“type = ?“, false)
      render json: @user, status: :ok
    end
  end

  # GET /user
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # POST /user
  def create
    @user = User.create!(user_params)
    render json: @user, status: :ok
  end

  # DELETE /user/{id}
  def destroy
    @user.destory
  end
  
  def user_params
    params.require(:user).permit(:name, :email)
  end

end
