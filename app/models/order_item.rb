class OrderItem < ActiveRecord::Base

  after_validation :set_shipped, on: :create

  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, numericality: { only_integer: true }
  validates :product_id, presence: true
  validates :order_id, presence: true

  def self.enough_inventory
    self.joins(:product).where('quantity <= products.inventory_total')
  end

  def self.not_enough_inventory
    self.joins(:product).where('quantity > products.inventory_total')
  end

  def set_shipped
    self.shipped = false
  end
end
