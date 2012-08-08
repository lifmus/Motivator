class GoalsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @goal = Goal.find(params[:id])
  end

  def new
    @goal = Goal.new
    @goal.objectives.build
  end

  def create
    @goal = Goal.new(params[:goal])
    if !current_user
       redirect_to new_user_session_path, notice: 'You must sign in to create a goal.'
    else
      @goal.user = current_user
        if @goal.save
          render action: "new"
         # redirect_to @goal, notice: 'Goal was successfully created.'
         # We need to decide how to move forward - should we have both partials render on the new page? How do we redirect after the pledge partial?
        else
          render action: "new"
        end
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    @objective = @goal.objectives.first #BUGBUG only works for one objective
    @days = []
    # days_passed = end_of_month.advance(:days=>2).day - end_of_month.at_beginning_of_week.day + 1
    7.times { | num | @days << Time.now.at_beginning_of_week + num.days }
  end

  def update
    @goal = Goal.find(params[:id])
    @objective = Objective.find(params[:objective_id])
    params[:day].each do |key, value|
      @objective.steps.find_or_create_by_completed_at(:completed_at => value)
    end

    redirect_to @goal
  end
end
