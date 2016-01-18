class OrderItemsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @orders = @user.orders
  end

  def shipped
    order_item = OrderItem.find(params[:id])
    order_item.update(:shipped => !order_item.shipped)
    Order.check_order_shipped(order_item)
    redirect_to :back
  end
end
