class TaskController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false
  before_action :authenticate_devise_api_token!

  def index
    render json: current_devise_api_user.tasks, status: :ok
  end

  def show
    devise_api_token = current_devise_api_token
    render json: devise_api_token.resource_owner.tasks.find(params[:id]), status: :ok
  end

  def create
    devise_api_token = current_devise_api_token;
    @task = devise_api_token.resource_owner.tasks.create!(task_params)
    render json: @task, status: :ok
  end

  def destroy
    devise_api_token = current_devise_api_token
    @task =  devise_api_token.resource_owner.tasks.find(params[:id])
    @task.destroy;
    render json: @task, status: :ok
  end

  private

  def task_params
    params.require(:task).permit(:title, :priority, :category)
  end
end
