class ChargesController < ApplicationController
  def new
  end

  def create
    @goal = Goal.find(params[:goal_id])
    @charge = Charge.create :amount => (@goal.pledge.amount*100).to_i,
                            :goal_id => @goal.id,
                            :transaction_type => "initial charge"

    # current_user.charge_card((@goal.pledge.amount*100), current_user, @goal)
    redirect_to goal_path(@goal)
  end

  def show
  end
end
