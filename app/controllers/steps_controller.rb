class StepsController < ApplicationController

  def index
    @steps = current_user.steps.all
  end

  def update
    @step = current_user.steps.find(params[:id])
    @step.image = params[:step][:image]
    @step.save
    redirect_to steps_path
  end


  def edit
    @step = current_user.steps.find(params[:id])
  end

  def create
    @goal = current_user.goals.find(params[:goal_id])
    @step = @goal.objectives.first.steps.new :completed_at => Time.now.to_date
    if @step.save
      redirect_to @goal
    else
      redirect_to :back, alert: 'You already recorded that step today'
    end
  end

  def show
    @step = current_user.steps.find(params[:id])
  end


  def new
    @step = current_user.steps.find(params[:id])

  end

end