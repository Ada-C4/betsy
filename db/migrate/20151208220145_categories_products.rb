class CategoriesProducts < ActiveRecord::Migration
  def change
    create_table :categories_products do |t|
      t.integer :product_id
      t.integer :category_id
    end
  end
end
