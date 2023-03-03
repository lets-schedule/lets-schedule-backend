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
        render json: { error: "incorrect number of filter items", status: 400 }.to_json, status: 400
        return
      end

      if filters.length == 1
        opp = filters[0][0]
        stOrEnd = filters[0][1]
        if (!validateFilterParameters(op, stOrEnd, filters[0][0])) 
            return
        end
        

          whereQuery = stOrEnd + " " + op + " ?"
          @events = @curr_task.events.where(whereQuery, date)
        end

        if filters.length == 2
          whereQuery1 = "" + filters[0][1] + " " + filters[0][0] + " ?" 
          whereQuery2 = "" + filters[1][1] + " " + filters[1][0] + " ?"
          @events = @curr_task.events.where(whereQuery1, DateTime.parse(filters[0][2])).where(whereQuery2, DateTime.parse(filters[1][2]))
        end


      else
        @events = @curr_task.events
      end

      render json: @events, status: :ok
    end

    # /event?filter[]=<opp>,<startTime | endTime>,<datetime>
    def filter
      devise_api_token = current_devise_api_token

      if params[:filter].present?

        filters = []

        params[:filter].each do |value|
          triple = value.split(',')
          filters << triple
        end

        puts filters
        puts 

        if (filters[0].empty? || (params[:filter].length > 2))
          render json: { error: "incorrect number of filter items", status: 400 }.to_json, status: 400
          return

        end

        # if there is one filter present
        if filters.length == 1
          opp = filters[0][0]
          startOrEnd = filters[0][1]
          date = filters[0][2]
          if !validateFilterParameters(opp, startOrEnd, date)
            return
          end

          whereQuery = startOrEnd + " " + opp + " ?"
          @events = Event.where(task_id: devise_api_token.resource_owner.tasks).where(whereQuery, date)
        end

        if filters.length == 2
          if filters[1].empty?
            render json: { error: "filter is empty", status: 400 }.to_json, status: 400
            return 
          end

          opp1 = filters[0][0]
          startOrEnd1 = filters[0][1]
          date1 = filters[0][2]
          opp2 = filters[1][0]
          startOrEnd2 = filters[1][1]
          date2 = filters[1][2]


          if !validateFilterParameters(opp1, startOrEnd1, date1)
            return
          end
          if !validateFilterParameters(opp2, startOrEnd2, date2)
            return
          end

          whereQuery1 = "" + filters[0][1] + " " + filters[0][0] + " ?" 
          whereQuery2 = "" + filters[1][1] + " " + filters[1][0] + " ?"

          puts "\n"
          puts whereQuery1
          puts whereQuery2

          @events = Event.where(task_id: devise_api_token.resource_owner.tasks).where(whereQuery1, filters[0][2]).where(whereQuery2, filters[1][2])
        end

      else
        @events = Event.where(task_id: devise_api_token.resource_owner.tasks)
      end

      render json: @events, status: :ok

    end

    def show
      devise_api_token = current_devise_api_token
      render json: devise_api_token.resource_owner.tasks.find(params[:task_id]).events.find(params[:id]), status: :ok
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

    # PATCH /task/{task_id}/event/{id}
    def update

      @event = current_devise_api_user.tasks.find(params[:task_id]).events.find(params[:id])

      if @event.update(event_params)
        render json: @event, status: :ok
      else
        render json: { errors: current_devise_api_user.errors.full_messages }, status: :unprocessable_entity
      end

    end

    private

    def event_params
      params.require(:event).permit(:startTime, :endTime, :filter)
    end

    def validateFilterParameters(opp, strtEnd, date)

      if opp == nil
        render json: { error: "operator value is nil", status:400 }.to_json, status: 400
        return false;
      end
      if strtEnd == nil
        render json: { error: "startTime or endTime parameter is nil", status:400 }.to_json, status: 400
        return false;
      end
      if date == nil
        render json: { error: "date value is nil", status:400 }.to_json, status: 400
        return false;
      end

      if (opp != "<" && opp != "=" && opp != ">" && opp != ">=" && opp != "<=")
        render json: { error: "Invalid operator used in filter", status: 400 }.to_json, status: 400
        return false
      end

      if (strtEnd != "startTime" && strtEnd != "endTime")
        render json: { error: "Invalid filter paramamter. Must filter on startTime or endTime", status: 400 }.to_json, status: 400
        return false
      end

      return true
    end

  end
