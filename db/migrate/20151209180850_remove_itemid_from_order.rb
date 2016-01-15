class RemoveItemidFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :item_id, :integer
  end
end
