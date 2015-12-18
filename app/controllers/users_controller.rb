class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :products]
  before_action :require_login, only: [:update, :destroy, :edit]
  before_action :correct_user, only: [:update, :destroy, :edit, :show]
  before_action :require_logout, only: [:new]

  def index
    @users = User.all.includes(:products).sort_by { |user| user.average_rating }.reverse!
  end

  def show
  end

  def new
    @user = User.new
  end

  def products
    if logged_in? && current_user == @user
      @products = @user.products.paginate(page: params[:page], per_page: 12).order(active: :desc)
    else
      @products = @user.products.paginate(page: params[:page], per_page: 12).where(active: true)
    end
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render "new"
    end
  end

  def update
    if @user.update(user_params)
      redirect_to users_path
    else
      render "edit"
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end


  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :name)
  end
end
