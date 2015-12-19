class AddProductIdToOrderItems < ActiveRecord::Migration
  def change
    add_column(:order_items, :product_id, :integer)
    add_index :order_items, :product_id
  end
end
