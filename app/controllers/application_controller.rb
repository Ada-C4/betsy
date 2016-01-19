class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def my_order
    unless cookies[:order].nil?
      @order ||= Order.find(cookies.signed[:order])
    else
      @order = Order.new(status: "pending")
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    if current_user.nil?
      flash[:error] = "You must be logged in to view this section"
      redirect_to new_session_path
    end
  end

  def not_require_login
    if !current_user.nil?
      flash[:error] = "You are already logged in"
      redirect_to products_path
    end
  end

  def check_user_product
    if @current_user != nil
      product = params[:product_id]
      if Product.find(product).user == @current_user
        flash[:error] = "ERROR! You can NOT review your own products!"
        redirect_to user_product_path(@current_user.id, product)
      end
    end
  end

  def check_user_id
    if @current_user != nil
      user = params[:user_id]
      if @current_user.id != user.to_i
        flash[:error] = "You can't view another user's content"
        redirect_to user_path(@current_user.id)
      end
    end
  end

  def check_user_product_details
    if @current_user != nil
      user = params[:id]
      if @current_user.id != user.to_i
        flash[:error] = "You can't view another user's content"
        redirect_to user_path(@current_user.id)
      end
    end
  end

end
