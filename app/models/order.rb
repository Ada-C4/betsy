class Order < ActiveRecord::Base
  has_many :order_items
  has_many :products, through: :order_items

  validates_presence_of :name, :bill_zip, :cc_exp, :cc_num, :city, :email, :sec_code, :state, :street, :zip
  validates :city, length: { maximum: 30 }
  # validates :cc_num, length: { is: 4 }
  validates :status, inclusion: { in: %w(Pending Paid Complete Cancelled) }

  def total_cost
    # call this on an order to get its total $ cost (or revenue depending on your perspective)
    total_revenue = 0
    order_items = self.order_items

    order_items.each do |orderitem|
      total_revenue += orderitem.cost
    end

    return total_revenue
  end
end
