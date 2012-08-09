class CreditcardsController < ApplicationController
   before_filter :authenticate_user!

  def new
  end

  def create
      @goal = Goal.find(params[:goal_id])
      if current_user.name
        @name = current_user.name
      else
        @name = "not given"
      end
        customer = Stripe::Customer.create(
        :card => params[:stripeToken],
        :email => current_user.email,
        :description => @name
      )
      current_user.stripe_customer_id = customer.id
      current_user.save
      redirect_to goal_path(@goal)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
    @goal = Goal.find(params[:id])

  end
end

# test card: 4242424242424242
