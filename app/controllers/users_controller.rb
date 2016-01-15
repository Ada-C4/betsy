class UsersController < ApplicationController
before_action :navbar_categories, only: [:index]
before_action :find_user, only: [:show, :dash, :product_dash, :order_dash]
before_action :only_current_user, only: [:dash, :order_dash]

  def index
    @users = User.all
    @cat = Category.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(strong_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Quartzy! You are now logged in."
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def dash
  end

  def product_dash
  end

  def order_dash
    @user = @current_user
    session[:rev_status] = params[:rev_status] if !params[:rev_status].nil?
    session[:order_status] = params[:order_status] if !params[:order_status].nil?
    session[:order_status] = 'all' if session[:order_status].nil?
  end

  private

  def strong_params
    params.require(:user).permit(:username, :email_address, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
