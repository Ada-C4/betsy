class ChangeDefaultValueForPhotoUrlAttribute < ActiveRecord::Migration
  def change
    change_column :products, :photo_url, :string, :default => "https://s3-us-west-2.amazonaws.com/ada-seabay/defaultsea.jpg"
  end
end
