class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :status
      t.string :email
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :credit_name
      t.integer :credit_num
      t.integer :cvv
      t.datetime :exp_date

      t.timestamps null: false
    end
  end
end
