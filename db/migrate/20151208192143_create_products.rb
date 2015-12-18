class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.integer :merchant_id
      t.string :description
      t.string :photo_url
      t.integer :category_id
      t.integer :inventory

      t.timestamps null: false
    end
  end
end
