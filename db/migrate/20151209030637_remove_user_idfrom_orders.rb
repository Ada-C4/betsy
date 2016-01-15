class RemoveUserIdfromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :user_id, :integer
  end
end
