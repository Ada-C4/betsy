class OrderItemsController < ApplicationController
  # before_action :set_order_item, only: [:show, :edit, :update, :destroy]
  #
  def index
    @user = User.find(params[:user_id])
    @orders = @user.orders
  end
  #
  # def show
  #   @user = User.find(params[:user_id])
  # end
  #
  # def new
  #   @order_item = OrderItem.new
  #   @order = Order.find(params[:order_id])
  #   @user = User.find(params[:user_id])
  # end
  #
  # def edit
  #   @user = User.find(params[:user_id])
  #   @order = Order.find(params[:order_id])
  #   @user = User.find(params[:user_id])
  # end
  #
  # def create
  #   @user = User.find(params[:user_id])
  #   @order = Order.find(params[:order_id])
  #   @order_item = OrderItem.new(order_item_params)
  #     if @order_item.save
  #       redirect_to user_order_order_items_path(@user,@order.id)
  #     else
  #       render "new"
  #     end
  # end

  def shipped
    user = User.find(params[:user_id])
    order_item = OrderItem.find(params[:id])
    if !order_item.shipped
      order_item.update(:shipped => true)
      Order.check_order_shipped(order_item)
    else
      order_item.update(:shipped => false)
      Order.check_order_shipped(order_item)
    end
    redirect_to :back
  end

  # def update
  #  @order_item.update(order_item_params)
  #  redirect_to user_order_order_items_path
  # end
  #
  # def destroy
  #   @user = User.find(params[:user_id])
  #   @order = Order.find(params[:order_id])
  #   @order_item.destroy
  #   redirect_to user_order_order_items_path(@user, @order)
  # end
  #
  # private
  #
  #   def set_order_item
  #     @order_item = OrderItem.find(params[:id])
  #   end

    # def order_item_params
    #   params.require(:order_item).permit(:product_id, :order_id, :quantity)
    # end
end
