class SessionsController < ApplicationController

  def new
  end

  def create
    data = params[:session_data] #this is from the form
    @merchant = Merchant.find_by_username(data[:username])
    if @merchant && @merchant.authenticate(data[:password])
      session[:user_id] = @merchant.id
      redirect_to merchant_home_path(@merchant.id)
    else
      flash.now[:error] = "No username/password combination matches. Please try again."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
