class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :status
      t.datetime :order_time
      t.string :customer_name
      t.string :customer_email
      t.string :customer_addres
      t.integer :customer_card_last_four
      t.integer :customer_card_exp_month
      t.integer :customer_card_exp_year

      t.timestamps null: false
    end
  end
end
