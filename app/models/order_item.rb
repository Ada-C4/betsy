class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  validates :order_id, presence: true
  validates :product_id, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  def cost
    self.product.price * self.quantity
  end

  def self.cost_of_many(array)
    total = 0

    array.each do |orderitem|
      total += orderitem.cost
    end

    return total
  end
end
