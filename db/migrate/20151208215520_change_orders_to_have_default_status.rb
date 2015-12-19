class ChangeOrdersToHaveDefaultStatus < ActiveRecord::Migration
  def change
    change_column :orders, :status, :string, :default => "Pending"
  end
end
