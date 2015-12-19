class AddDefaultValueToPhotoUrlAttribute < ActiveRecord::Migration
  def change
    change_column :products, :photo_url, :string, :default => "/assets/images/defaultsea.jpg"
  end
end
