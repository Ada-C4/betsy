class ProductsController < ApplicationController

before_action only: [:show, :edit, :update, :retire] { @product = Product.find(params[:id]) }

  def index
    if params[:search]
      @products = Product.search(params[:search]).where(retire: false).order(stock: :desc)
    else
    @products = Product.where(retire: false).order(stock: :desc)
    end
  end

  def show
    @review = Review.new(product_id: @product.id)
    if @order_item = @current_order.orderitems.where("product_id = ?", params[:id]).first
    else
      @order_item = Orderitem.new(product_id: @product.id)
    end
  end

  def category
    @category = Category.find_by(name: params[:category_name])
    @products = @category.products.where(retire: false)
  end

  def robot
    @robot = Robot.find(params[:id])
    @products = @robot.products.where(retire: false)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to robot_path(current_robot)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    @product.update(product_params)
    if @product.save
      redirect_to robot_path(current_robot)
    else
      render 'edit'
    end
  end

  def retire
    @product.retire ? @product.retire = false : @product.retire = true
    @product.save
    redirect_to robot_path(@product.robot_id)
  end

  private

  def product_params
    params.require(:product).permit([:name, :description, :price, :robot_id, :categories, :picture_url, :stock, :category_ids => []])
  end
end
