class AddIndexToOrderItems < ActiveRecord::Migration
  def change
    add_column(:order_items, :order_id, :integer)
    add_index :order_items, :order_id
  end
end
