class Review < ActiveRecord::Base
  belongs_to product
  validates :rating, presence: true
  validates :rating, numericality: { less_than_or_equal_to 5 }
end
