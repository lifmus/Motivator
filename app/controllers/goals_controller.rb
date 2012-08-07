class GoalsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @goal = Goal.find(params[:id])
    @objective = @goal.objectives.first #BUGBUG only works for one objective
    @days = []
    7.times { | num | @days << Time.now.at_beginning_of_week + num.days }
  end

  def new
  end

  def edit
  end

  def update
    @goal = Goal.find(params[:id])
    @objective = Objective.find(params[:objective_id])
    params[:days].each do |day|
      # Step.find_or_create_by_completed_at(:completed_at => day, :objective_id => @objective.id)
    end

    redirect_to @goal
  end
end
