class AddJumbotronPhotoUrlToCategories < ActiveRecord::Migration
  def change
      add_column(:categories, :jumbotron_photo_url, :string)
  end
end
