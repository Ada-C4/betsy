class OrderitemsDefaultQuantity < ActiveRecord::Migration
  def change
    change_column(:orderitems, :quantity, :integer, :default => 1)
  end
end
