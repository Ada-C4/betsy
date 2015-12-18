class ProductsController < ApplicationController

  before_action :require_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @products = get_products
    @order_item = current_order.order_items.new
    @categories = Category.all
    @merchants = Merchant.all
    @header = get_header
  end

  def get_products
    if request.original_url.include?("categories")
      products = Category.find(params[:category_id]).products
      products = products.where("retire = ?", false)
    elsif request.original_url.include?("merchants")
      products = Product.where("merchant_id = ?", params[:merchant_id])
      # If merchant is logged in and is viewing their products page
      if current_user && params[:merchant_id].to_i == current_user.id
        products = Product.where("merchant_id = ?", params[:merchant_id])
      # If merchant is logged in and is viewing another merchant's product page
      else
        products = Product.where("merchant_id = ?", params[:merchant_id])
        products = products.where("retire = ?", false)
      end
    elsif params[:search]
      products = Product.search(params[:search]).order("created_at DESC")
      products = products.where("retire = ?", false)
    else
      products = Product.where("retire = ?", false)
    end
    return products
  end

  def get_header
    if request.original_url.include?("categories")
      header = Category.find(params[:category_id]).name
    elsif request.original_url.include?("merchants")
      header = Merchant.find(params[:merchant_id]).user_name
    elsif params[:search]
      header = "Search Results"
    else
      header = "All Products"
    end
    return header

  end

  def show
    id = params[:id]
    @product = Product.find(id)
    @order_item = current_order.order_items.new
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    @product.merchant_id = @current_user.id
    @categories = Category.all
    if @product.save
      update_categories(@product)
      redirect_to product_path(@product)
    else
      render "new"
    end
  end

  def destroy
    id = params[:id]
    product = Product.find(id)
    if product.merchant_id == @current_user.id
      Product.delete(id)
      redirect_to merchant_path(@current_user.id)
    else
      redirect_to product_path(id)
    end
  end

  def edit
    id = params[:id]
    @product = Product.find(id)
    @categories = Category.all
    if @product.merchant_id != @current_user.id
      redirect_to product_path(id)
    end
  end

  def update
    id = params[:id]
    @product = Product.find(id)
    if @product.merchant_id != @current_user.id
      redirect_to product_path(@product)
    else
      @product.update(product_params)
      update_categories(@product)
      if @product.save
        redirect_to product_path(@product.id)
      else
        render "edit"
      end
    end
  end

  def retire
    item = Product.find(params[:id])
    if item.retire == false
      item.update(retire: true)
    else
      item.update(retire: false)
    end
    redirect_to :back
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description, :photo_url, :inventory)
  end

  def update_categories(product)
    if !params[:categories].nil?
      categories_array = params[:categories]
      product.categories = []
      categories_array.each do |category|
        product.categories << Category.find(category)
      end
    end
  end
end
