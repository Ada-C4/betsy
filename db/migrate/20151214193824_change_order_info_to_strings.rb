class ChangeOrderInfoToStrings < ActiveRecord::Migration
  def change
    change_column :orders, :credit_num, :string
    change_column :orders, :zip,        :string
    change_column :orders, :cvv,        :string
  end
end
