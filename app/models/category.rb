class Category < ActiveRecord::Base
  has_and_belongs_to_many :products
  validates :name, presence: true, uniqueness: true, length: { maximum: 15 }
end
