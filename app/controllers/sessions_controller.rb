class SessionsController < ApplicationController

  def new; end

  def create
    data = params[:session_data]
    @robot = Robot.find_by_email(data[:email])

    if !@robot.nil?
      if @robot.authenticate(data[:password])
        # robot is authenticated
        session[:robot_id] = @robot.id
        redirect_to robot_path(@robot)
      end
    else
      flash.now[:error] = "Incorrect email or password"
      render :new
    end
  end

  def destroy
    session[:robot_id] = nil
    redirect_to root_url
  end
end
