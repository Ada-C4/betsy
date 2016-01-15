class Review < ActiveRecord::Base
  belongs_to :product

  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true }
  validates :rating, :inclusion => 1..5
end
