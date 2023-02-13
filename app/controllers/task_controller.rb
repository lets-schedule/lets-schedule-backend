class TaskController < ApplicationController
  def show
    @task = Task.find(params[:id])
    render json: @task, status: :ok
  end

  def index
    tasks = Task.all
    render json: tasks, status: :ok
  end

  def create
    task = Task.create!(task_params)
    render json: taks, status: :ok
  end

  def task_params
    params.require(:task).permit(:user, events: [], :conflict)
end
