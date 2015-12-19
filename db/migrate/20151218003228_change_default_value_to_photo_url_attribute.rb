class ChangeDefaultValueToPhotoUrlAttribute < ActiveRecord::Migration
  def change
    change_column :products, :photo_url, :string, :default => "/app/assets/images/defaultsea.jpg"
  end
end
