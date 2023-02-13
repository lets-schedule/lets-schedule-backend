class ConflictController < ApplicationController
  # POST constraints/{id}
  def create
    @constraint = Constraint.new(user_params)
    if @constraint.save
      render json: @constraint, status: :created
    else
      render json: {errors; @constraint.errors.full_messages },
        status: :unprocessable_entity
    end
  end

  # GET /constraints
  def index
    @constraint = Contraint.all
    render json: @constraint, status: :ok
  end

  # DELETE /constraints
  def destroy
    @constraint.destroy
  end

  def user_params
    params.permit(
      :duration, :due_time
    )
  end

end
