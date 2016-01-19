class User < ActiveRecord::Base
  has_many :products
  has_many :order_items

  has_secure_password

  validates :first_name, presence: true
  validates :first_name, length: { :minumum => 1, :maximum => 30 }
  validates :last_name, presence: true
  validates :last_name, length: { :minimum => 1, :maximum=>30 }
  validates :email, presence: true
  validates_uniqueness_of :email
  validates :email, email_format: { message: "doesn't look like an email address" }

  def revenue
    revenue = 0
    products.each do |product|
      product.order_items.each do |oi|
        if oi.order.status != "cancelled"
          revenue += (product.price * oi.quantity)

        end
      end
    end
    return revenue
  end

  def revenue_by_status(status)
    revenue = 0
    products.each do |product|
      product.order_items.each do |oi|
        if oi.order.status == status
            revenue += (product.price * oi.quantity)
        end
      end
    end
    return revenue
  end

  def num_orders
    orders = []
    products.each do |product|
      product.order_items.each do |oi|
        if orders.include? oi.order.id
          next
        else
          orders.push(oi.order.id)
        end
      end
    end
    return orders.length
  end

  def num_orders_by_status(status)
    orders = []
    products.each do |product|
      product.order_items.each do |oi|
        if oi.order.status == status
          if orders.include? oi.order
            next
          else
            orders.push(oi.order)
          end
        end
      end
    end
    return orders.length
  end

  def find_order_item(order)
    user_id = self.id
    order.order_items.each do |oi|
      if oi.product.user.id == user_id
        return oi.shipped
      end
    end
  end


end
