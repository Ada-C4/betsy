class User < ActiveRecord::Base
  has_many :products
  has_many :order_items, through: :products
  has_many :orders, through: :order_items
  has_many :reviews, through: :products
  has_secure_password

  before_validation { self.email = email.downcase if self.email } # ensures emails are all lowercase

  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def average_rating
    total_rating = reviews.sum(:rating)
    total_reviews = reviews.count(:rating)
    total_reviews == 0 ? (return 0) : (return total_rating * 1.0 / total_reviews)
  end
end
