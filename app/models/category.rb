class Category < ActiveRecord::Base
    has_and_belongs_to_many :products
    validates :name, presence: true, uniqueness: true
    has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100>", home: "480x300" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
