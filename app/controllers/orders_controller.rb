class OrdersController < ApplicationController
  before_action :require_login, only: [:index, :pending, :cancelled, :paid, :completed, :show]
  before_action :get_order, only: [:confirm, :show]
  before_action :get_order_items, only: [:index, :status]
  before_action :get_order_item_revenue, only: :show

  def checkout
    # get @current_order info from carts controller
    @cart_items = session[:cart]
    # @cart_items looks like { "1" => 2 }
    # want instance_vars @p1, @p2, etc. set equal to the keys of the hash
    @order = Order.new
    @order_item = OrderItem.new
    @products = []
    if !@cart_items.nil?
      @cart_items.each do |k,v|
        product = Product.find(k.to_i)
        v.times { @products.push(product) }
      end
    end
    @order_total = 0

    @products.each do |product|
      @order_total += product.price
    end
  end

  def create
    @cart_items = session[:cart]
    @order = Order.new(order_params[:order])
    # this checks to make sure the products are still in stock before creating a new order
    # multiple sessions can have the same items in cart at the same time
    # if one session purchases, the other session's cart doesn't know about it
    @inventory_errors = []
    @cart_items.each do |k,v|
      product = Product.find(k.to_i)
      if product.quantity < v
        # stores error which will go into flash later
        error = "#{product.name} does not have sufficient stock to purchase. This item has been removed from your cart."
        @inventory_errors.push(error)
        # removes the sold out items from the cart
        discrepancy = (v - product.quantity).abs
        discrepancy.times do
          session[:cart][k] -= 1
          session[:cart].delete_if { |key,value| value == 0 }
        end
      end
    end
    # if there are no inventory problems and the cart isn't empty and the order saves
    if @inventory_errors.empty? && !@cart_items.nil? && @order.save
      # create order items
      @cart_items.each do |k,v|
        product = Product.find(k.to_i)
        OrderItem.create(
        order_id: @order.id,
        product_id: product.id,
        quantity: v
        )
        # decrement stock of purchased products
        new_product_quantity = product.quantity - v
        product.update(quantity: new_product_quantity)
        # update order status from pending to paid
        @order.update(status: "Paid")
      end
      # remove items from cart
      session[:cart] = nil
      redirect_to order_confirm_path(@order.id)
    else
      # tells guest which products were sold out and removed from cart
      if !@inventory_errors.empty?
        flash[:error] = @inventory_errors.join(", ")
      end
      redirect_to orders_checkout_path
    end
  end

  def confirm
    @all_order_items = @order.order_items

    @order_total = @order.total_cost
  end

  def index
    @total_revenue = OrderItem.cost_of_many(@all_orderitems)
  end

  def show

  end

  def status
    @orderitems = []
    @total_revenue = 0
    @status = params[:status]

    if @status == "pending"
      @all_orderitems.each do |orderitem|
        if orderitem.order.status == "Pending"
          @orderitems.push(orderitem)
        end
      end

    elsif @status == "paid"
      @all_orderitems.each do |orderitem|
        if orderitem.order.status == "Paid"
          @orderitems.push(orderitem)
        end
      end
      @orderitems.each do |orderitem|
        @total_revenue += orderitem.cost
      end
    elsif @status == "complete"
      @all_orderitems.each do |orderitem|
        if orderitem.order.status == "Complete"
          @orderitems.push(orderitem)
        end
      end
      @orderitems.each do |orderitem|
        @total_revenue += orderitem.cost
      end
    elsif @status == "cancelled"
      @all_orderitems.each do |orderitem|
        if orderitem.order.status == "Cancelled"
          @orderitems.push(orderitem)
        end
      end
      @orderitems.each do |orderitem|
        @total_revenue += orderitem.cost
      end
    end
  end

  private

  def order_params
    params.permit(order:[:purchase_time, :name, :email, :street, :city, :state, :zip, :cc_num, :cc_exp, :sec_code, :bill_zip, :status])
  end

  def get_order
    @order = Order.find(params[:id])
  end

  def get_order_items
    @products = current_merchant.products

    # get all orders with at least one of current merchant's products
    @orders = []

    @products.each do |product|
      @orders.push(product.orders)
    end

    @orders = @orders.flatten

    # get all order items for current merchant's products
    @all_orderitems = []

    @products.each do |product|
      @all_orderitems.push(product.order_items)
    end

    @all_orderitems = @all_orderitems.flatten
  end

  def get_order_item_revenue
    # get all order items for an order
    @all_order_items = @order.order_items

    # get all order items for the order that belong to signed in merchant
    @order_items = []

    @all_order_items.each do |oi|
      if oi.product.merchant_id == current_merchant.id
        @order_items.push(oi)
      end
    end

    # find total revenue for the signed in merchant's order items
    @order_total = OrderItem.cost_of_many(@order_items)
  end

end
