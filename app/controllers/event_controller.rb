class EventController < ApplicationController

# GET /event/{id}
  def show
    @event = Event.find(params[:id])
    render json: @event, status: :ok
  end

  # GET /event
  def index
    events = Event.all
    render json: events, status: :ok
  end

  # POST /event/{id}
  def create
    event = Event.create!(event_params)
    render json: event, status: :ok
  end

  # DELETE /event/{id}
  def destroy
    @event.destroy
  end

  def event_params
    params.require(:event).permit(:task)

  # PATCH /event/{id}

end
