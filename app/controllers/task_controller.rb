class TaskController < ApplicationController


  # GET /task/{id}
  def show
    @task = Task.find(params[:id])
    render json: @task, status: :ok
  end

  # GET /task
  def index
    @task = Task.all
    render json: @task, status: :ok
  end

  # POST /task/{}
  def create
    @task = Task.create!(task_params)
    render json: @task, status: :ok
  end

  # DELETE /task/{id}
  def destroy
    Task.destroy(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :user_id) 
  end
end
