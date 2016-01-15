class Category < ActiveRecord::Base
  has_many :categories_products, :dependent => :destroy
  has_many :products, through: :categories_products
  belongs_to :user

  validates :name, presence: true
  validates :name, uniqueness: true

  def top(x)
    products = self.products.where(retired: false).sort_by{|pro| pro.avg_rating}
    return products[0..x-1]
  end

end
