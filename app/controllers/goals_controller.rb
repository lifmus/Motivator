class GoalsController < ApplicationController
  # before_filter :authenticate_user!

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
         redirect_to @goal, notice: 'Goal was successfully created.'
        else
          render action: "new"
        end
    end
  end

  def edit
  end
end
