class EventController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false
  before_action :authenticate_devise_api_token!

  def index
    render json: current_devise_api_user.tasks.find(params[:task_id]).events, status: :ok
  end

  def show
    devise_api_token = current_devise_api_token
    render json: devise_api_token.resource_owner.tasks.find(params[:id]).events.find(params[:id]), status: :ok
  end

  def create
    devise_api_token = current_devise_api_token;
    @event = devise_api_token.resource_owner.tasks.find(params[:task_id]).events.create!(event_params)
    render json: @event, status: :ok
  end

  def destroy
    devise_api_token = current_devise_api_token;
    @event = devise_api_token.resource_owner.tasks.find(params[:task_id]).events.find(params[:id])
    @event.destroy
    render json: @event, status: :ok
  end

  private

  def event_params
    params.require(:event).permit(:startTime, :endTime)
  end
end
