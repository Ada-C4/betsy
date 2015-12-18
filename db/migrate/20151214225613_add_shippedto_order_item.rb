class AddShippedtoOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :shipped, :boolean
  end
end
