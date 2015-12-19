class AddStatustoOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :status, :string, default: "not shipped"
  end
end
