class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update]
  before_action :find_user, only: [:new, :edit, :create, :update]
  before_action :all_categories, only: [:new, :edit, :create, :update]
  before_action :require_login, only: [:new, :edit, :create, :update, :retire]
  before_action :correct_user, only: [:new, :edit, :create, :update, :retire]

  def index
    @products = Product.all.paginate(page: params[:page], per_page: 12).where(active: true)
  end

  def show
    @review = Review.new
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    params[:product][:price] = params[:product][:price].to_f * 100
    @product = Product.create(product_params) do |p|
      p.user_id = @user.id
      if params[:categories].nil?
        p.categories = []
      else
        p.categories = Category.find(params[:categories])
      end
    end
    if @product.save
      redirect_to user_products_path(@product.user)
    else
      render :new
    end
  end

  def update
    @product.assign_attributes(product_params)
    if params[:categories].nil?
      @product.categories = []
    else
      @product.categories = Category.find(params[:categories])
    end
    if @product.save
      redirect_to user_products_path(@product.user)
    else
      render :edit
    end
  end

  def retire
    product = Product.find(params[:id])
    if product.active
      product.update(:active => false)
    else
      product.update(:active => true)
    end
    redirect_to user_products_path(product.user)
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def all_categories
    @categories = Category.all
  end

  def product_params
    params.require(:product).permit(:name, :price, :photo_url, :stock, :description, :active)
  end
end
