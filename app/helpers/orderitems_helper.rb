module OrderitemsHelper
  def ship_status(orderitem)
    orderitem.shipped ? "Cancel Shipping" : "Ship it"
  end

  def ship_color(orderitem)
    orderitem.shipped ? "btn btn-danger" : "btn btn-success"
  end
end
