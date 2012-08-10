class GoalsController < ApplicationController
  before_filter :authenticate_user!#, :except => [ :show, :index]

  def index
    @goals = current_user.goals
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def new
    @goal = Goal.new
    @goal.objectives.build
  end

  def create
    @goal = current_user.goals.new(params[:goal])
    if @goal.save
      redirect_to new_pledge_path(:goal_id => @goal), notice: 'Goal was successfully created.'
    else
      render action: "new"
    end
  end

  def edit
    @goal = current_user.goals.find(params[:id])
    @objective = @goal.objectives.first #BUGBUG only works for one objective
    @days = []
    # @objective.build_steps
    7.times { | num | @days << Time.now.at_beginning_of_week + num.days }
  end

  def update
    @goal = current_user.goals.find(params[:id])
    @objective = @goal.objectives.find(params[:objective_id])
    # accepts nested attributes, related to line 30
    params[:day].each do |key, value|
      @objective.steps.find_or_create_by_completed_at(:completed_at => value)
    end

    redirect_to @goal
  end
end
