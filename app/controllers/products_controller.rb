class ProductsController < ApplicationController
  before_action :require_login, only: [:index, :edit, :new]
  before_action :find_product, only: [:show, :edit, :retire, :activate]

  def index
  end

  def all_products
    @products = Product.all
  end

  def new
    @product = Product.new
    @action = "create"
    @method = :post
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    @product = merchant.products.new(product_params)
    if @product.save
      redirect_to merchant_products_path
    else
      render :new
    end
  end

  def show
    @reviews = @product.reviews
    @review = Review.new
    @can_review = current_merchant_product?
    @average = @product.average_review.round
  end

  def edit
    @action = "update"
    @method = :patch
  end

  def update
    @product = Product.update(params[:id], product_params)
    if @product.save
      redirect_to merchant_products_path
    else
      render :edit
    end
  end

  def destroy
   Product.find(params[:id]).destroy
   redirect_to merchant_products_path(params[:merchant_id])
  end

  def create_review
    if current_merchant_product?
      @review = Review.create(review_params)
    else
      flash[:error] = "A merchant cannot review their own product."
    end

    redirect_to product_path(review_params[:product_id])
  end

  def retire
    @product.status = "Retired"
    @product.save!
    redirect_to merchant_products_path(@product.merchant_id)
  end

  def activate
    @product.status = "Active"
    @product.save!
    redirect_to merchant_products_path(@product.merchant_id)
  end

  private

  def current_merchant_product?
    if current_merchant.nil?
      return true
    else
      current_merchant.products.each do |product|
        if product.id == params[:id].to_i
          return false
        end
      end
      return true
    end
  end

  def product_params
    params.require(:product).permit(:name, :price, :image, :photo_url, :description, :quantity, {category_ids:[]})
  end

  def review_params
    params.require(:review).permit(:rating, :description, :product_id)
  end

  def find_product
    @product = Product.find(params[:id])
  end

end
