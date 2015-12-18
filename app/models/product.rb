class Product < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :reviews
  has_and_belongs_to_many :categories

  validates :name, :price, :user_id, presence: true
  validates :name, uniqueness: true
  validates_numericality_of :price, :greater_than => 0
  validates_numericality_of :stock, :greater_than_or_equal_to => 0
  validates :photo_url, format: {with: /\.(png|jpg)\Z/i}, allow_nil: true

  def review_total
    reviews.sum(:rating)
  end

  def review_average
    reviews.average(:rating) || 0
  end

  def review_rounded
    return review_average.round
  end

  def self.increment_stock(order)
    order.order_items.each do |order_item|
      product = Product.find(order_item.product_id)
      new_quantity = product.stock + order_item.quantity
      product.update(:stock => new_quantity)
    end
  end

  def self.decrement_stock(products_sold)
    products_sold.each do |p, q|
      p.stock -= q
      p.save
    end
  end
end
