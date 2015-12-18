class ModifyOrders < ActiveRecord::Migration
  def change
    add_column :orders, :street_address, :string
    add_column :orders, :zip_code, :integer
    add_column :orders, :state, :string
    remove_column :orders, :customer_address
    add_column :orders, :security_code, :integer
    remove_column :orders, :customer_card_last_four
    add_column :orders, :card_number, :integer
    add_column :orders, :name_on_card, :string
  end
end
