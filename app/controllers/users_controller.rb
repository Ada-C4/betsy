class UsersController < ApplicationController
  before_action :current_user

  before_action :require_login, only: [:show, :new_category]
  before_action :not_require_login, only: [:new]
  before_action :check_user_product_details, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash.now[:error] = "Please fill out all fields with valid information"
      render :new
    end
  end

  def show
    @user = User.find(session[:user_id])
    @category = Category.new
  end

  def new_category
    user_id = params[:user_id]
    @category = Category.new(category_params)
    if @category.save
      session[:message] = "You have created a new category: #{@category.name}"
      redirect_to user_path(user_id)
    else
      if @category.errors.messages[:name].include? "can't be blank"
        flash[:error] = "Categories must have a name!"
      elsif @category.errors.messages[:name].include? "is too short (minimum is 3 characters)"
        flash[:error] = "Category names must be greater than 3 characters and less than 15 characters"
      elsif @category.errors.messages[:name].include? "is too long (maximum is 15 characters)"
        flash[:error] = "Category names must be greater than 3 characters and less than 15 characters"
      end
      redirect_to user_path(user_id)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
