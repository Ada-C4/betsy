class ChangeDefaultonQuantity < ActiveRecord::Migration
  def change
    change_column_default :orderitems, :quantity, 1
  end
end
