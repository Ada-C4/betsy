class SessionsController < ApplicationController
  before_action :not_require_login, only: [:new, :create]
  before_action :require_login, only: [:destroy]

  def new
  end

  def create
    data = params[:session_data]
    @user = User.find_by_email(data[:email])
    if @user.nil?
      flash.now[:error] = "Hmmm, that password/email combination doesn't seem quite right..."
      render :new
    elsif @user.authenticate(data[:password])
    # User is in the system and authenitcated
      session[:user_id] = @user.id
      redirect_to root_path
    else
      # user is not Authenticated
      flash.now[:error] = "Hmmm, that password/email combination doesn't seem quite right..."
      render :new
    end
    #redirect_to new_user_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
