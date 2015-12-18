# require 'pry'
class Order < ActiveRecord::Base
  has_many :orderitems
  validates :credit_name, presence: true, on: :update, if: :awaiting_confirmation?
  validates :email,       presence: true, on: :update, if: :awaiting_confirmation?
  validates :credit_num,  presence: true, numericality: { only_integer: true }, length: { is: 16 }, on: :update, if: :awaiting_confirmation?
  validates :cvv,         presence: true, numericality: { only_integer: true }, length: { is: 3 },  on: :update, if: :awaiting_confirmation?
  validates :address,     presence: true, on: :update, if: :awaiting_confirmation?
  validates :city,        presence: true, on: :update, if: :awaiting_confirmation?
  validates :state,       presence: true, on: :update, if: :awaiting_confirmation?
  validates :zip,         presence: true, numericality: { only_integer: true }, length: { is: 5 },  on: :update, if: :awaiting_confirmation?

  def total_items
    total = 0
    self.orderitems.each do |item|
      total += item.quantity if !item.quantity.nil?
    end
    return total
  end

  def total_amount
    total = 0
    items = self.orderitems

    items.each do |item|
      total += item.product.price * item.quantity
    end
    return total
  end

  def awaiting_confirmation?
    status == "Awaiting confirmation"
  end

  def complete?
    complete = true
    a = []
    self.orderitems.each do |item|
      if item.shipped?
        a << true
      else
        a << false
      end
    end

    a.include?(false) ? complete = false : complete = true
    
    return complete
  end
end
