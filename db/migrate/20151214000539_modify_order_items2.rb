class ModifyOrderItems2 < ActiveRecord::Migration
  def change
    rename_column :order_items, :status, :shipped? 
  end
end
