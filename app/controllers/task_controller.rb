class TaskController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false  
  before_action :authenticate_devise_api_token!

  def index

    @tasks = current_devise_api_user.tasks

    if params[:sort].present?

      @tasks = current_devise_api_user.tasks.order(params[:sort])

    end

    render json: @tasks, status: :ok

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

  def update
    
    curr_token = current_devise_api_token
    if curr_token.resource_owner.tasks.find(params[:id]).update(task_params)
      render json: current_devise_api_user.tasks.find(params[:id]), status: :ok
    else
      render json: { errors: current_devise_api_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private


  def task_params
    params.require(:task).permit(:title, :priority, :category, :sort)
  end
end
