class StepsController < ApplicationController

  def new

  end

  def create
    @goal = current_user.goals.find(params[:goal_id])
    @step = @goal.objectives.first.steps.new :completed_at => Time.now.to_date
    if @step.save
      redirect_to @goal
    else
      redirect_to edit_goal_path(@goal)
    end
  end

end