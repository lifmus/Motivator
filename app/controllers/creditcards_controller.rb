class CreditcardsController < ApplicationController
  before_filter :authenticate_user!

  def new
  end

  def create
    @goal = Goal.find(params[:goal_id])

    current_user.create_stripe_customer_id(params[:stripeToken])

    redirect_to creditcard_path(@goal)
  end

  def show
    @goal = Goal.find(params[:id])
  end
end

# test card: 4242424242424242
