class Merchant < ActiveRecord::Base
  has_many :products
  has_many :order_items, through: :products
  has_many :orders, through: :order_items, source: :order
  has_secure_password

  validates :user_name, presence: true, uniqueness: true, length: { maximum: 25 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 50 }

end
