class PledgesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @goal = current_user.goals.find(params[:goal_id])
    @pledge = Pledge.new
  end

  def create
    @goal = current_user.goals.find(params[:goal_id])
    @pledge = @goal.build_pledge(params[:pledge])
     if @pledge.save
        if current_user.stripe_customer_id
          redirect_to creditcard_path(@goal) , notice: 'Pledge was successfully created.'
        else
          redirect_to new_creditcard_path(:goal_id => @goal), notice: 'Pledge was successfully created.'
        end
      else
        render action: "new"
      end
  end

  def edit
    @pledge = current_user.pledges.find(params[:id])
    @goal = @pledge.goal
  end

  def update
    @goal = current_user.goals.find(params[:goal_id])
    @pledge = @goal.pledge
    if @pledge.update_attributes(params[:pledge])
      flash[:notice] = "Pledge was successfully updated."
      redirect_to creditcard_path(@goal)
    else
      render action: "edit"
    end

  end
end
