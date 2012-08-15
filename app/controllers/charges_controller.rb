class ChargesController < ApplicationController
  def new
  end

  def create
    @goal = Goal.find(params[:goal_id])
    current_user.charge_card((@goal.pledge.amount*100), current_user, @goal)
    redirect_to goal_path(@goal)
  end

  def show
  end
end
