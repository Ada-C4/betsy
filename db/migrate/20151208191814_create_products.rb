class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :photo_url
      t.string :description
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
