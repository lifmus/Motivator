class PledgesController < ApplicationController
  before_filter :authenticate_user!

  def new
    if params[:goal_id].nil?
      redirect_to new_goal_path, notice: 'Please create a goal.'
    else
      @goal = Goal.find(params[:goal_id])
      @pledge = Pledge.new
    end
  end

  def create
    @goal = Goal.find(params[:goal_id])
    @pledge = Pledge.new(params[:pledge])
    @pledge.goal = @goal
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

  def show
  end
end
