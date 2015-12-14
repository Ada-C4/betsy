class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:index]
  before_action :correct_user, only: [:index]

  def index
    @user = User.find(params[:user_id])
    @orders = @user.orders
  end


  def show
    @user = User.find(params[:user_id])
  end

  def new
    @order = Order.new
  end

  def edit
    @user = User.find(params[:user_id])
  end


  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        redirect_to user_orders_path
      else
        render "new"
      end
    end
  end


  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }

      else
        format.html { render :edit }

      end
    end
  end


  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }

    end
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end


    def order_params
      params.require(:order).permit(:email, :street, :city, :state, :zip, :cc_num, :cc_exp, :cc_cvv, :cc_name)
    end
end
