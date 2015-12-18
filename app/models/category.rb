class Category < ActiveRecord::Base
  has_and_belongs_to_many :products
  validates :name, presence: true, uniqueness: true
  before_save :downcase_fields


  def downcase_fields
    self.name.downcase!
  end

end
