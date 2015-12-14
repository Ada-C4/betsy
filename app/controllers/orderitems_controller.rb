class OrderitemsController < ApplicationController

  #this method hooks up to button in cart to delete an orderitem, OR you might end up redirected here if you update at orderitem quantity to zero.
  #if you are deleting the last item in the cart, the whole order gets deleted
  def destroy
    @orderitem = Orderitem.find(params[:id])
    @order = @orderitem.order
    total_items = @order.orderitems
    if total_items.count == 1
      redirect_to :controller => :orders, :action => :clear_cart
    else
      @orderitem.destroy
      redirect_to cart_path
    end
  end


  #happens in cart
  #the only thing update can do is change the quantity
  #a form will need to be sent for a particular orderitem on the cart page
  #let them type in an integer, and if it's zero delete it
  def update
    @orderitem = Orderitem.find(params[:id])
    if orderitem_params[:orderitem][:quantity] == 0
      redirect_to action: :destroy
    else
      @orderitem.update(orderitem_params)
      redirect_to cart_path
    end
  end

  private

  def orderitem_params
    params.permit(orderitem:[:quantity])
  end

end
