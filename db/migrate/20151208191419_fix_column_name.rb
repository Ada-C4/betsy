class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :orders, :customer_addres, :customer_address
  end
end
