class AddPurchaseTimeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :purchase_time, :datetime
  end
end
