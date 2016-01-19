class Review < ActiveRecord::Base
  belongs_to :product

  validates :rating, presence: true
  validates :rating, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5}
  validates :product_id, presence: true

  def self.reverse_by_product(params)
    self.where("product_id = #{params[:id]}").reverse
  end

end
