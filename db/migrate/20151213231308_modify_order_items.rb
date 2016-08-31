class ModifyOrderItems < ActiveRecord::Migration
  def change
    # remove_column :order_items, :status, :string
    add_column :order_items, :status, :boolean
  end
end
