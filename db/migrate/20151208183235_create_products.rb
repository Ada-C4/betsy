class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :robot_id
      t.integer :cat_id
      t.string :picture_url
      t.integer :stock

      t.timestamps null: false
    end
  end
end
