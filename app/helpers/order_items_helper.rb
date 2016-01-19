module OrderItemsHelper

  def print_cart_total
    if @instock.length == 1
      return "You have #{@instock.length} item in your cart!"
    else
      return "You have #{@instock.length} items in your cart!"
    end
  end

  def print_unavaliable_status(item)
    if item.product.inventory_total == 0
      return "YOUR CART HAS CHANGED: #{item.product.name} is now unavaliable"
    else
      return "YOUR CART HAS CHANGED: You selected #{item.quantity} of #{item.product.name} but only #{item.product.inventory_total} are currently available. Please change your quantity if you would still like to purchase this item."
    end
  end

  def still_avaliable
    @still_avaliable = []
    @outofstock.each do |item|
      if item.product.inventory_total != 0
        @still_avaliable.push(item)
      end
    end
    return @still_avaliable
  end

end
