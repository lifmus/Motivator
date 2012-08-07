class GoalsController < ApplicationController
  before_filter :authenticate_user!

  def show
  end

  def new
    @goal = Goal.new
    @goal.objectives.build
  end

  def create
    @goal = Goal.new(params[:goal])
    @goal.user = current_user
      if @goal.save
       redirect_to @goal, notice: 'Goal was successfully created.'
      else
        render action: "new"
      end
  end

  def edit
  end
end
