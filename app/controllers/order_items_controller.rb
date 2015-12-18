class OrderItemsController < ApplicationController
  before_action :current_user

  def create
    my_order
    @order.save
    cookies.signed[:order] = @order.id

    item = @order.order_items.where(product_id: params[:product_id]).first

    unless item.nil?
      item.update(quantity: order_item_params[:quantity])
    else
      @order.order_items << item = OrderItem.create(order_item_params)
    end

    redirect_to cart_path
  end

  def cart
    @instock = my_order.instock
    @outofstock = my_order.outofstock
    @total = my_order.cart_total
  end

  def update
    order_item = OrderItem.find(params[:id])

    if order_item_params[:quantity] == "0"
      order_item.destroy
    else
      order_item.update(quantity: order_item_params[:quantity])
    end

    redirect_to cart_path
  end

  def destroy
    order_item = OrderItem.find(params[:id])
    order_item.destroy

    redirect_to cart_path
  end

private

  def order_item_params
    params.require(:order_item).permit(:quantity).merge(product_id: params[:product_id])
  end
end
