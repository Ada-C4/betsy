

class ProductsController < ApplicationController
  include ApplicationHelper
  before_action :navbar_categories, only: [:index]
  before_action :current_user_owns_product, only: [:update, :delete, :retire]
  before_action :find_product, only: [:retire, :buy, :show, :destroy]



  def buy
    #if there is not yet an order_id in session, make it now
    #this is totally independent of being logged in.
    #then if the id is nil, make an order and put it's id in the session hash
    #if there already is an order in the session, add the product to it.
      @current_order = current_order
      if !@current_order
        session[:order_id] = []
        order = Order.pending(@product)
        session[:order_id] = order.id
        flash[:notice] = "Added #{@product.name} to cart."
      else
        #logic for whether or not one is in cart already
        if @current_order.orderitems.where(product_id: @product.id) != []
          #product is already in order
          @orderitem = @current_order.orderitems.where(product_id: @product.id).first
          @orderitem.update_attribute(:quantity, @orderitem.quantity + 1 )
          flash[:notice] = "Added another #{@orderitem.product.name} to cart."
        else
          #product is not already in order
          @orderitem = Orderitem.create!(quantity: 1, order_id: @current_order.id, product_id: @product.id)
          flash[:notice] = "Added #{@orderitem.product.name} to cart."
        end
      end
      #in any case, want to stay on same page after clicking button
      redirect_to request.referrer
  end


  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    # @categories = @product.categories
    @action = "create"
    @all_categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    @product.price = (params[:product][:price].to_f * 100).to_i
    if @product.save
      redirect_to product_path(@product)
    else
      flash[:error] = "Why don't you double check those product specs, eh?"
      render :new
    end
  end

  def show
    @title = "#{@product.name} Info"
    @stars = @product.avg_rating
    @reviews = @product.reviews
    @review = Review.new
  end

  def review
    @product = Product.find(params[:product_id])
    @review = Review.create(review_params)
    redirect_to product_path(@product)
  end

  def edit
    id = params[:id]
    @product = Product.find(id)
    @categories = @product.categories
    @all_categories = Category.all
    @action = "update"
    @title = "Edit #{@product.name}"
  end

  def update
    @product = Product.update(params[:id], product_params)
    # @product.price = (params[:product][:price].to_f * 100).to_i
    @product.category_ids = params[:product][:category_ids]
    if @product.save
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def retire
    id = params[:id]
    @product = Product.find(id)
    @product.retire_toggle
    @product.save
    redirect_to request.referrer
  end

  def destroy
    @product.destroy
    flash[:notice] = "You've deleted #{@product.name}"
    redirect_to request.referrer
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:user_id, :retired, :category_ids, :name, :price, :description, :photo_url, :stock)
  end

  def review_params
    params.require(:review).permit(:rating, :body).merge(product_id: params[:product_id])
  end
end
