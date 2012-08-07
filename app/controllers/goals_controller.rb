class GoalsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @goal = Goal.find(params[:id])
  end

  def new
  end

  def edit
  end
end
