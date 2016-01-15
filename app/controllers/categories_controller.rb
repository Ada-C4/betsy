class CategoriesController < ApplicationController
before_action :require_login, only: [:new, :create, :edit, :update]
before_action :navbar_categories, only: [:index, :show]

  def index
    @cat = Category.all
  end
  def show
    @category = Category.find(params[:id])
  end
  def new
    @category = Category.new
    @action = "create"
  end
  def create
    @category = Category.new(category_params)
    @category.user_id = session[:user_id]
    if @category.save
      redirect_to user_products_dash_path(@category.user_id)
    else
      render :new
    end
  end
  def edit

  end
  def update

  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
