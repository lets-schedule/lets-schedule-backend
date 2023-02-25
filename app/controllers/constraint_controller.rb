class ConstraintController < ApplicationController

  skip_before_action :verify_authenticity_token, raise: false  
  before_action :authenticate_devise_api_token!

  def index
    render json: current_devise_api_user.tasks.find(params[:task_id]).constraint, status: :ok
  end

  def create
    devise_api_token = current_devise_api_token
    @constraint = devise_api_token.resource_owner.tasks.find(params[:task_id]).create_constraint(constraint_params)
    render json: @constraint, status: :ok
  end

  def destroy
    devise_api_token = current_devise_api_token
    @constraint = devise_api_token.resource_owner.tasks.find(params[:task_id]).constraint
    @constraint.destroy
    render json: @constraint, status: :ok
  end

  def update
    
    if current_devise_api_user.tasks.find(params[:task_id]).constraint.update(constraint_params)
      
      render json: current_devise_api_user.tasks.find(params[:task_id]).constraint, status: :ok
    else
      render json: { errors: current_devise_api_user.errors.full_messages }, status: :unprocessable_entity
    end

  end


  private

  def constraint_params
    params.require(:constraint).permit(:dueTime, :duration)
  end
end
