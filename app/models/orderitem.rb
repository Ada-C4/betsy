class Orderitem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  validates :quantity, presence: true



  # decerements inventory of product
  def item_shipped
    self.status = 'shipped'
    self.save
  end

end
