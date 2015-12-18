class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.integer :inventory_total
      t.boolean :retired
      t.string :image_url
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
