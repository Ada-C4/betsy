class ChangeOrders2 < ActiveRecord::Migration
  def change
    add_column :orders, :city, :string
    add_column :orders, :billing_zip_code, :integer
  end
end
