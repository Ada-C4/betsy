class User < ActiveRecord::Base
  has_many :products, :dependent => :destroy
  has_many :categories

  validates :username, presence: true
  validates :username, uniqueness: true

  validates :email_address, presence: true
  validates :email_address, uniqueness: true

  validates_confirmation_of :password, :message => "Passwords should match"
  has_secure_password

  # returns the top x number of products the user sells based on their average rating
  def top(x)
    products = self.products.where(retired: false).sort_by{|pro| pro.avg_rating}
    return products[0..x-1]
  end

  # returns all the orders that have any products in them belonging to the user
  def orders
    orders = []
    self.products.each do |product|
      product.orders.each do |order|
        orders.push(order) if !orders.include?(order)
      end
    end
    return orders
  end

  def orderitems
    orderitems = []
    self.products.each do |product|
      product.orderitems.each do |oi|
        orderitems.push(oi)
      end
    end
    return orderitems
  end

  # returns orderitems for the user that are in a given order
  def orderitems_by_order(order)
    orderitems = []
    self.products.each do |product|
      product.orderitems.each do |oi|
        orderitems.push(oi) if oi.order == order
      end
    end
    return orderitems
  end

  # returns all the orders a user is associated with, based on the order status
  def orders_by_status(status)
    orders = []
    self.products.each do |product|
      product.orders.each do |order|
        orders.push(order) if order.status == "#{status}"
      end
    end
    return orders
  end

  # returns total revenue for a user
  def revenue
    rev = []
    self.products.each do |product|
      product.orderitems.each do |orderitem|
        rev.push(orderitem.product.price * orderitem.quantity)
      end
    end
    total = rev.inject(0) {|r, e| r + e}
    return total
  end

  # returns revenue for user by order status
  def rev_by_status(status)
    rev = []
    self.products.each do |product|
      product.orderitems.each do |orderitem|
        rev.push(orderitem.product.price * orderitem.quantity) if orderitem.order.status == "#{status}"
      end
    end
    total = rev.inject{|r, e| r + e}
    return total
  end

end
