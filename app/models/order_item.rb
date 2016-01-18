class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  validates :quantity, :product_id, presence: true
  validates_numericality_of :quantity, :greater_than => 0


  def self.find_not_shipped(orders)
    array = []
    orders.each do |order|
      order.order_items.each do |order_item|
        array.push(order_item) if !order_item.shipped
      end
    end
    return array
  end

end
