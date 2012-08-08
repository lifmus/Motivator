class CreditcardsController < ApplicationController
   before_filter :authenticate_user!

  def new
  end

  def create
    current_user.stripeToken = params[:stripeToken]
    current_user.save
    redirect_to(root_path)
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

# 4167250053657955
