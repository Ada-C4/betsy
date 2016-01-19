module OrdersHelper
  def shipped_status
    if @user.find_order_item(@order) == true
      return "Yes"
    else
      return "No"
    end
  end

end
