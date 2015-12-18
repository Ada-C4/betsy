class ModifyShipped < ActiveRecord::Migration
  def change
    rename_column :order_items, :shipped?, :shipped
    change_column_default(:order_items, :shipped, false)
  end
end
