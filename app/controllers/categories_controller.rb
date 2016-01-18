class CategoriesController < ApplicationController
  before_action :find_category, only: [:show, :edit, :update]

  def index
    @categories = Category.all
    @category = Category.new
  end


  def show
    @products = @category.products.paginate(page: params[:page], per_page: 12).where(active: true)
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      @categories = Category.all
      flash[:error] = "Error creating category."
      render :index
    end
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
