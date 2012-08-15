class StaticPagesController < ApplicationController
  def index
    if signed_in?
      redirect_to goals_path
    end
  end

  def index2

  end
end
