class OrderItemsController < ApplicationController
  before_action :check_if_product_is_in_cart, only: [:create]

  def create
    @order = current_order
    @order_item = @order.order_items.create(order_item_params)
    if @order_item.save
      redirect_to cart_path
    else
      if @order_item.product.inventory == 1
        flash[:error] = "Sorry, there is only #{@order_item.product.inventory} #{@order_item.product.name} available."
      elsif @order_item.product.inventory == 0
        flash[:error] = "Sorry, there are no #{@order_item.product.name.pluralize} available."
      else
        flash[:error] = "Sorry, there are only #{@order_item.product.inventory} #{@order_item.product.name.pluralize} available."
      end
      redirect_to product_path(@order_item.product)
    end
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items

    redirect_to cart_path
  end

  def update
    @order_item = OrderItem.find(params[:id])
    @order_item.update_attributes(order_item_params)
    if @order_item.save
      redirect_to cart_path
    else
      flash[:error] = "Sorry, there are only #{@order_item.product.inventory} #{@order_item.product.name.pluralize} available."
      redirect_to cart_path
    end
  end

  def check_if_product_is_in_cart
    order = current_order
    @product_id = params[:order_item][:product_id]
    product_in_cart = order.order_items.select {|order_item| order_item.product_id == @product_id.to_i}

    if !product_in_cart.empty?
      update_product_in_cart(product_in_cart[0])
    end
  end

  def update_product_in_cart(product_in_cart)
    current_quantity = product_in_cart.quantity
    additional_quantity = params[:order_item][:quantity].to_i
    params[:order_item][:quantity] = current_quantity + additional_quantity

    product_in_cart.update_attributes(order_item_params)

    redirect_to cart_path

  end

  def shipped
    @order_item = OrderItem.find(params[:id])
    @order = Order.find(@order_item.order_id)
    #the conditional below prevents cancelled or pending orders from being shipped
    if @order.status == "paid"
      @order_item.update_attribute(:shipped, 'true')
        if @order.order_items.all? {|item| item.shipped == true}
          @order.update_attribute(:status, "complete")
        end
    else
      flash[:error] = "You can only ship items that are in 'paid' status"
    end
    redirect_to merchant_path
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id, :order_id, :status)
  end
end
