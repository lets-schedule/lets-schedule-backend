class EventController < ApplicationController

  # GET /event/{id}
  def show
    @event = Event.find(params[:id])
    render json: @event, status: :ok
  end

  # GET /event
  def index
    @events = Event.all
    render json: @events, status: :ok
  end

  # POST /event/{id}
  def create
    @event = Event.create!(event_params)
    render json: @event, status: :ok
  end

  # DELETE /event/{id}
  def destroy
    Event.destory(params[id])
  end

  # PATCH /event/{id}
  def update 
    unless @event.update(user_params)
      render json: {errors: @event.errors.full_messages },
        status: :unprocessable_entity
    end
  end

  def event_params
    params.require(:event).permit(:task_id, :start_date_time, :end_date_time)
  end


end
