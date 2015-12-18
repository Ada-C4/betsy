class Order < ActiveRecord::Base
  has_many :order_items
  has_many :products, :through => :order_items
  validate :must_have_order_items
  validates :customer_email, presence: true, on: :update, if: :paid?
  validates :street_address, presence: true, on: :update, if: :paid?
  validates :city, presence: true, on: :update, if: :paid?
  validates :zip_code, presence: true, length: {minimum: 5 }, on: :update, if: :paid?
  validates :name_on_card, presence: true, on: :update, if: :paid?
  validates :card_number, presence: true, on: :update, if: :paid?
  validates :customer_card_exp_month, presence: true, numericality: { greater_than: 0 }, on: :update, if: :paid?
  validates :customer_card_exp_year, presence: true, numericality: { greater_than: 0 }, on: :update, if: :paid?
  validates :billing_zip_code, presence: true, length: {minimum: 5 }, on: :update, if: :paid?
  validates :security_code, presence: true, length: {minimum: 3 }, on: :update, if: :paid?
  #validate :expiration_date_cannot_be_in_the_past

  #this validation ruined all our specs and we can't tell why. Leaving this in to ask Charles why it had that effect
  #def expiration_date_cannot_be_in_the_past
  #  if customer_card_exp_year == Date.today.year
  #    if customer_card_exp_month < Date.today.month
  #      errors.add(:customer_card_exp_year, "can't be in the past")
  #    end
  #  elsif customer_card_exp_year < Date.today.year
  #    errors.add(:customer_card_exp_year, "can't be in the past")
  #  end
  #end

  def paid?
    status == "paid"
  end

  def must_have_order_items
    if status == "paid" || status == "cancelled" || status == "complete"
      validates_presence_of :order_items
    end
  end

# This method will let an admin cancel an order, but we don't have
# functionality to do so yet.
#   def admin_cancel
#     if status == "paid"
#       update_attribute(:status, "cancelled")
#     else
#       flash.now[:error] = "It's too late to cancel this order!"
#     end
#     redirect_to :back
#   end
end
