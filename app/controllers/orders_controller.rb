class OrdersController < ApplicationController
  def show
    id = params[:id]
    @order = Order.find(id)
    @order_items = @current_user.order_items.where(order_id: id)
  end

  def cart
    @order = current_order
    @order_items = current_order.order_items
    @subtotal = subtotal(@order_items)
  end

  def checkout
    @order_items = current_order.order_items
    check_if_quantity_is_available(@order_items)
    @subtotal = subtotal(@order_items)
  end

  def confirmation
    @order = current_order
    @order.status = "paid"
    @order.attributes = order_params
    @order.card_number = params[:order][:card_number].last(4)
    if !@order.save
      @subtotal = subtotal(@order.order_items)
      render :checkout
    else
      update_inventory
      session[:order_id] = nil
    end
  end

  def check_if_quantity_is_available(order_items)
    # binding.pry
    order_items.each do |item|
      if item.quantity > item.product.inventory
        if item.product.inventory == 1
          flash[:error] = "Sorry, there is only #{item.product.inventory} #{item.product.name} available."
        elsif item.product.inventory == 0
          flash[:error] = "Sorry, there are no #{item.product.name.pluralize} available."
        else
          flash[:error] = "Sorry, there are only #{item.product.inventory} #{item.product.name.pluralize} available."
        end
        render :cart
      end
    end
  end

  def update_inventory
    @order.order_items.each do |order_item|
      order_item.product.update(inventory: order_item.product.inventory - order_item.quantity)
    end
  end

  def subtotal(order_items)
    sum = 0
    order_items.each do |order_item|
      sum += order_item.quantity * order_item.product.price
    end
    return sum
  end

  private

  def order_params
    params.require(:order).permit(:customer_name, :customer_email, :customer_card_exp_month, :security_code,
    :customer_card_exp_year, :street_address, :zip_code, :state, :city, :name_on_card, :billing_zip_code)
  end

end
