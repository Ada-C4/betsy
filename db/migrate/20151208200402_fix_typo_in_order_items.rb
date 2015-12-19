class FixTypoInOrderItems < ActiveRecord::Migration
  def change
    rename_column :order_items, :quanitity, :quantity
  end
end
