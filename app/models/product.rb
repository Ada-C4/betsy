class Product < ActiveRecord::Base
  belongs_to :merchant
  has_many :reviews
  has_many :order_items
  has_many :orders, through: :order_items
  has_and_belongs_to_many :categories

  validates_associated :reviews
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/



  def average_review
    reviews.average(:rating) || 0
    # if @reviews.length != 0
    #   total = 0
    #   @reviews.each do |review|
    #     total += review.rating
    #   end
    #   @average = (total / @reviews.length)
    # end
  end


end
