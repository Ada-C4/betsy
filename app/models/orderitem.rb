class Orderitem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :quantity_cannot_exceed_stock
  validates :order_id, presence: true
  validates :product_id, presence: true

  def quantity_cannot_exceed_stock
    if !self.quantity.nil? && !self.product_id.nil? && !self.order_id.nil?
      if self.order.status != "paid"
        if self.quantity > self.product.stock
          errors.add(:quantity, "can't exceed present stock")
        end
      end
    end
  end
end
