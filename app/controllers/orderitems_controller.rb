class OrderitemsController < ApplicationController
  def add_to_cart
    if @current_order.orderitems.where("product_id = ?", params[:id]).first
      @order_item = @current_order.orderitems.where("product_id = ?", params[:id]).first
      @order_item.increment(:quantity, order_item_params[:quantity].to_i)
    else
      @order_item = Orderitem.new(product_id: params[:id])
      @order_item.quantity = order_item_params[:quantity].to_i
    end
    if @order_item.order_id.nil?
      @current_order.orderitems.push(@order_item)
    end
    @order_item.save
    flash[:success] = "You've updated your cart."
    redirect_to product_path(params[:id])
  end

  def increase_quantity
    @order_item = @current_order.orderitems.where("product_id = ?", params[:id]).first
    @order_item.quantity += 1
    if @order_item.save
      redirect_to :back
    else
      flash[:error] = "Quantity not increased. Cannot exceed current stock."
      redirect_to :back
    end
  end

  def decrease_quantity
    @order_item = @current_order.orderitems.where("product_id = ?", params[:id]).first
    @order_item.quantity -= 1
    if @order_item.save
      redirect_to :back
    else
      @order_item.destroy
      flash[:error] = "Item removed from your cart."
      redirect_to :back
    end
  end

  def remove
    @order_item = @current_order.orderitems.where("product_id = ?", params[:id]).first
    @order_item.destroy
    redirect_to :back
  end

  def ship
    @order_item = Orderitem.find(params[:id])
    @order_item.shipped ? @order_item.shipped = false : @order_item.shipped = true
    @order_item.save
    redirect_to :back
  end

  private

  def order_item_params
    params.require(:orderitem).permit([:product_id, :quantity])
  end


end
