class CartsController < ApplicationController

  def index
    @cart = session[:cart]
  end

  def add
    product = Product.find(params[:id])
    product_id = params[:id]
    quantity = params[:product][:add_quantity].to_i
    session[:cart] = {} if !session[:cart]
    cart = session[:cart]
    if cart[product_id].nil? && product.stock >= quantity # adding product for the first time
      cart[product_id] = quantity
      redirect_to cart_path
    elsif cart[product_id] && product.stock >= cart[product_id] + quantity # adding to product already in cart
      cart[product_id] += quantity
      redirect_to cart_path
    else
      flash[:error] = "Sorry, there is not enough product in stock to fulfill your request."
      redirect_to user_product_path(product.user_id, product.id)
    end
  end

  def update
    product_id = params[:id]
    new_quantity = params[:product][:new_quantity].to_i
    product = Product.find(product_id)
    if product.stock >= new_quantity
      session[:cart][product_id] = new_quantity
    else
      flash[:error] = "Sorry, there is not enough product in stock to fulfill your request."
    end
    redirect_to cart_path
  end

  def destroy
    product_id = params[:id]
    session[:cart].delete(product_id)
    session[:cart] = nil if session[:cart] == {}
    redirect_to cart_path
  end

end
