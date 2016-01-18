class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :email
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :cc_num
      t.date :cc_exp
      t.integer :cc_cvv
      t.string :cc_name

      t.timestamps null: false
    end
  end
end
