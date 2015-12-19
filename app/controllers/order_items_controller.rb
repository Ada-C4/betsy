class OrderItemsController < ApplicationController
  before_action :require_login
  before_action :find_orderitem, only: [:edit, :update]

  def edit
  end

  def update
    @orderitem.update(order_items_params)
    redirect_to merchant_orders_path(@current_merchant.id)
  end

  private

  def order_items_params
    params.require(:order_item).permit(:status)
  end

  def find_orderitem
    @orderitem = OrderItem.find(params[:id])
  end
end
