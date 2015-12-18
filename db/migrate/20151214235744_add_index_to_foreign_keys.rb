class AddIndexToForeignKeys < ActiveRecord::Migration
  def change
    add_index :order_items, :product_id
    add_index :order_items, :order_id
    add_index :products, :user_id
    add_index :reviews, :product_id
  end
end
