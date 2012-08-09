class PledgesController < ApplicationController
  before_filter :authenticate_user!

  def new
    if params[:goal_id].nil?
      redirect_to new_goal_path, notice: 'Please create a goal.'
    else
      @pledge = Pledge.new
    end
  end

  def create
    @pledge = Pledge.new(params[:pledge])
     if @pledge.save
        redirect_to edit_goal_path(@pledge.goal_id), notice: 'Pledge was successfully created.'
      else
        render action: "new"
      end
  end

  def show
  end
end
