class GoalsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]

  def index
    @goals = signed_in? ? current_user.goals : []
    @public_goals = Goal.find_all_by_public(true) - @goals
  end

  def show
    @goal = Goal.find(params[:id])
    @steps_completed_at = []
    @steps_by_date = @goal.steps.each do |step|
      @steps_completed_at << step.completed_at.to_date
    end
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    if @goal.public == false
      redirect_to goals_path, notice: 'That is a private goal'
    end unless @goal.user == current_user
  end

  def new
    @goal = Goal.new
    @goal.objectives.build
  end

  def create
    @goal = current_user.goals.new(params[:goal])
    if @goal.save
      redirect_to new_goal_pledge_path(@goal), notice: 'Goal was successfully created.'
    else
      render action: "new"
    end
  end

  def edit
    @goal = current_user.goals.find(params[:id])
    @objective = @goal.objectives.first #BUGBUG only works for one objective
    @days = []
    # @objective.build_steps
    7.times { | num | @days << Time.now - num.days }
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
