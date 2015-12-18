module OrdersHelper
  def order_items(robot_id)
    Robot.find(robot_id).products
  end
end
