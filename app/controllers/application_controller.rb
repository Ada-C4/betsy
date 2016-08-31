class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_user

  def current_order
    return @order if @order
    if !session[:order_id].nil?
      @order = Order.find(session[:order_id])
    else
      @order = Order.create
      @order.update(status: "pending")
      session[:order_id] = @order.id
      return @order
    end
  end

	def current_user
 	  @current_user ||= Merchant.find(session[:merchant_id]) if session[:merchant_id]
	end

  def require_user
    if !logged_in?
      flash[:error] = "Please log in to view this section"
 	    redirect_to new_session_path
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def redirect_if_logged_in
    # if the session merchant id exists, find the merchant from that id and if they exist, redirect to their show_page.
    if logged_in?
      redirect_to merchant_path(@current_user)
    end
  end
end
