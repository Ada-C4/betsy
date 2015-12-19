class AddPhotoUrlToCategories < ActiveRecord::Migration
  def change
    add_column(:categories, :photo_url, :string)
  end
end
