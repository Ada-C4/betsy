class ProductItem < ActiveRecord::Base
  belongs_to :orderitem
  belongs_to :product
end
