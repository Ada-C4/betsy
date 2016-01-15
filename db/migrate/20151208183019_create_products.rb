class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :user_id
      t.integer :stock
      t.string :photo_url
      t.string :description

      t.timestamps null: false
    end
  end
end
