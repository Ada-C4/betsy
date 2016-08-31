class Product < ActiveRecord::Base
  has_many :reviews
  belongs_to :merchant
  has_and_belongs_to_many :categories
  has_many :order_items
  has_many :orders, through: :order_items

  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :description, length: {maximum: 500 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :merchant_id, presence: true
  validates :inventory, numericality: { greater_than_or_equal_to: 0 }

  def self.search(query)
    query = query.downcase
    where("lower(name) like ? OR lower(description) like ?", "%#{query}%", "%#{query}%")
  end
end
