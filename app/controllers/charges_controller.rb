class ChargesController < ApplicationController
  def new
  end

  def create
    @goal = Goal.find(params[:goal_id])
    if current_user.charge_card((@goal.pledge.amount*100), current_user.stripe_customer_id)
      Charge.create(:amount => (@goal.pledge.amount*100), :goal_id => @goal.id)
    end
    redirect_to goal_path(@goal)
  end

  def show
  end
end
