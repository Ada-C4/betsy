class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.datetime :purchase_time
      t.string :status
      t.string :name
      t.string :email
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip
      t.integer :cc_num
      t.date :cc_exp
      t.integer :sec_code
      t.integer :bill_zip

      t.timestamps null: false
    end
  end
end
