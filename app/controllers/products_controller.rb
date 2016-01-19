class ProductsController < ApplicationController
  before_action :current_user
  before_action :require_login, only: [:new, :create, :edit, :update, :retire]
  before_action :check_user_product, only: [:review]
  before_action :check_user_id, only: [:retire, :edit, :update]

  def index
    # This method contains the logic for the buttons to be able to
    # filter search options on the index page
    @categories = Category.all
    @merchants = User.all
    @products = Product.order(:created_at).where(retired: false)
    case params[:type]

      when "merch"
        @products = @products.where("user_id = #{params[:order]}")
      when "cat"
        prod = Product.where(retired: false)
        @products = prod.select {|product|
          rows = product.categories.where("category_id = #{params[:order]}")
          !rows.to_a.empty?
        }
      else
        @order = "prod"
    end
  end

  def show
    @product = Product.find(params[:id])
    @review = Review.new
    @reviews = Review.reverse_by_product(params)
    @order_item = my_order.order_items.new
  end

  def review
    review = Review.create(review_params)
    flash[:rating] = "You must give your review a star rating."
    redirect_to product_path(params[:product_id], anchor: "review")
  end

  def new
    @product = Product.new
    @action = "create"
    @categories = @product.categories
    @all_categories = Category.all
  end

  def create
    @user_id = session[:user_id]
    @product = Product.new(product_params)
    if params[:categories]
      params[:categories].each do |cat|
        @product.categories << Category.where(id:cat.to_i)
      end
    end
    if @product.save
      redirect_to user_path(@user_id)
    else
      @categories = @product.categories
      @all_categories = Category.all
      @action = "create"
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    @action = "update"
    @categories = @product.categories
    @all_categories = Category.all
  end

  def update
    user_id = session[:user_id]
    @product = Product.update(params[:id], product_params)
    @product.categories.clear
    @product.save
    if !params[:categories].nil?
      params[:categories].each do |cat|
        @product.categories << Category.where(id:cat.to_i)
      end
    end
    if @product.save
      redirect_to user_path(user_id)
    else
      @categories = @product.categories
      @all_categories = Category.all
      @action = "update"
      render :edit
    end
  end

  def retire
    product_id = params[:product_id]
    user_id = params[:user_id]
    product = Product.find(product_id)
    product.retired = true
    product.save
    redirect_to user_path(user_id)
  end

  private

  def review_params
    params.require(:review).permit(:review_text, :rating).merge(product_id: params[:product_id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :inventory_total, :retired, :image_url, :user_id)
  end

end
