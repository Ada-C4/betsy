class Review < ActiveRecord::Base
  belongs_to :product

  validates :rating, :product_id, presence: true
  validates :rating, numericality: { greater_than: 0, less_than: 6, message: "must be between 1 and 5" }
end
