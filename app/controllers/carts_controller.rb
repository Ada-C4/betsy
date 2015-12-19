class CartsController < ApplicationController
  before_action :cart_exists, only: [:add_quantity, :remove_quantity]
  before_action :find_product, only: [:add_quantity, :remove_quantity]

  def create
    session[:cart] = {}
  end

  def destroy
    session[:cart] = nil
    redirect_to root_path
  end

  def index
    cart_exists

    if session[:cart].length == 0
      @cart_items = nil
    else
      @cart_items = session[:cart]
    end
  end

  def add_quantity
    # add one of the product if it is in stock
    if @product.quantity == 0
      flash[:error] = "You cannot add more items than are in stock."
    elsif session[:cart][@id].nil?
      session[:cart][@id] = 1
      # if trying to add more to cart than are in stock, flash error
    elsif session[:cart][@id] + 1 > @product.quantity
      flash[:error] = "You cannot add more items than are in stock."
      # add another of product to cart
    else
      session[:cart][@id] += 1
    end
    redirect_to carts_path
  end

  def remove_quantity
    if session[:cart][@id].nil?
      flash[:error] = "This item has already been removed from your cart."
    else
      session[:cart][@id] -= 1
      session[:cart].delete_if { |k,v| v == 0 }
    end
    redirect_to carts_path
  end

  private

  def cart_exists
    if session[:cart].nil?
      create
    end
  end

  def find_product
    @id = params[:product_id]
    @product = Product.find(@id)
  end

end
