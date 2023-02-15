class TaskController < ApplicationController

  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  def show
    @task = Task.find(params[:id])
    render json: @task, status: :ok
  end

  def index
    @task = Task.all
    render json: @task, status: :ok
  end

  def create
    @task = Task.create!(task_params)
    render json: @task, status: :ok
  end

  def destroy
    Task.destroy(params[:id])
    
  end

  def task_params
    params.require(:task).permit(:title, :user_id) 
  end
end
