class Category < ActiveRecord::Base
  has_and_belongs_to_many :products

  validates :name, presence: true
  validates :name, length: { minimum: 3, maximum: 15 }
end
