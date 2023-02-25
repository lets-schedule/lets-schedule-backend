class EventController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false  
  before_action :authenticate_devise_api_token!

  def index
    @curr_task = current_devise_api_user.tasks.find(params[:task_id])

    if params[:filter].present?

      filters = []

      params[:filter].each do |value|
        triple = value.split(',')
        filters << triple
      end


      if (params[:filter].length == 0) || (params[:filter].length > 2)
        render json: { error: "incorrect number of filter items", status: 400 }.to_json, status: 404
        return
      end

      if filters.length == 1
        whereQuery = "" + filters[0][1] + " " + filters[0][0] + " ?",DateTime.parse(filters[0][2])
        @events = @curr_task.events.where(whereQuery)
      end

      if filters.length == 2
        whereQuery1 = "" + filters[0][1] + " " + filters[0][0] + " ?",DateTime.parse(filters[0][2])
        whereQuery2 = "" + filters[1][1] + " " + filters[1][0] + " ?",DateTime.parse(filters[1][2])
        @events = @curr_task.events.where(whereQuery1).where(whereQuery2)
      end


    else
      @events = @curr_task.events
    end

    render json: @events, status: :ok
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
    params.require(:event).permit(:startTime, :endTime, :filter)
  end
end
