class Order < ActiveRecord::Base
  has_many :order_items

  validates :status, presence: true
  validates_presence_of :email, :mailing_address, :zip, :name_on_card, :last_four, :card_exp, on: :update
  validates :last_four, numericality: { only_integer: true }, on: :update
  validates :zip, length: { is: 5 }, on: :update
  validate :card_exp_cannot_be_in_the_past

  def card_exp_cannot_be_in_the_past
    if card_exp.present? && card_exp < Date.today
      errors.add(:exp, "Can't be in the past")
    end
  end

  def total(user_id)
    revenue = 0
    order_items.each do |oi|
      if oi.product.user.id == user_id
        revenue += (oi.product.price * oi.quantity)
      end
    end
    return revenue
  end

  def instock
    self.order_items.enough_inventory
  end

  def outofstock
    self.order_items.not_enough_inventory
  end

  def cart_total
    self.instock.joins(:product).sum('quantity * products.price')
  end

  def adjust_stock
    self.order_items.each do |order_item|
      order_item.product.decrement!(:inventory_total, by = order_item.quantity)
    end
  end
end
