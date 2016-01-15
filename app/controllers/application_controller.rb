class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_user
  before_action :current_order
  before_action :items_in_cart


  def current_order
    if session[:order_id] && !!Order.exists?(session[:order_id])
    @current_order ||= Order.find(session[:order_id])
    end
  end

  def current_user
    if session[:user_id] && !!User.exists?(session[:user_id])
      @current_user ||= User.find(session[:user_id])
    end
  end

  def items_in_cart
    if current_order
      sum = []
      Order.find(session[:order_id]).orderitems.each do |oi|
        sum.push(oi.quantity)
      end
      @cart_num = sum.inject(0) {|r, e| r + e }
    else
      @cart_num = 0
    end
  end

  def require_login
    if current_user.nil?
      flash[:error] = "You must be logged in to view this section"
      redirect_to new_session_path
    end
  end

  def navbar_categories
    @navbar_cat =  Category.where(user_id: nil)
  end

  # checks that the user/:id, the :id is equal to current user
  def only_current_user
      if !@current_user || @current_user.id != params[:id].to_i
        flash[:error] = "You are not authorized to view that section"
        redirect_to root_path
      end
  end

  def current_user_owns_product
    if current_user.id != Product.find(params[:id]).user_id
      flash[:error] = "You are not authorized to view this section"
      redirect_to :back
    end
  end

end
