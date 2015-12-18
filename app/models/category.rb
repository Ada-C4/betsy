class Category < ActiveRecord::Base
  has_and_belongs_to_many :products
  validates :name, uniqueness: true
  validates :name, presence: true

  before_validation { self.name = name.downcase if self.name}
end
