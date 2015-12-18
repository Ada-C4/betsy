class Robot < ActiveRecord::Base
  has_many :products
  has_many :orderitems, :through => :products


  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: /@/
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  has_secure_password

  def revenue
    total = 0
      self.orderitems.each do |item|
        if item.order.status == "paid"
        total += item.quantity * item.product.price
      end
    end
    return total
  end
end
