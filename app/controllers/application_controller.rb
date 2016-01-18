class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  def correct_user
    id = params[:user_id] || params[:id]
    @user = User.find(id)
    if @user != current_user
      flash[:error] = "You do not have permission to access that page."
      redirect_to(root_path)
    end
  end

  def require_login
    if !logged_in?
      flash[:error] = "You must be logged in to complete that action."
      redirect_to login_path
    end
  end

  def require_logout
    if logged_in?
      flash[:error] = "You are currently logged in. You must log out to complete that action."
      redirect_to root_path
    end
  end
end
