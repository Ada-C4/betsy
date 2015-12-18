class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_robot
  before_action :current_order
  before_action :find_categories
  before_action :find_robots

  def find_categories
    @categories = Category.all
  end

  def find_robots
    @robots = Robot.all
  end

  def current_order
    return @current_order if !@current_order.nil?
    if session[:order_id]
      @current_order = Order.find(session[:order_id])
    else
      @current_order = Order.create(status: "pending")
      session[:order_id] = @current_order.id
    end
  end

  def current_robot
    @current_robot ||= Robot.find(session[:robot_id]) if session[:robot_id]
  end

  def require_login
    if current_robot.nil?
      flash[:error] = "You must be logged in to view this section"
      redirect_to new_session_path
    end
  end

  
end
