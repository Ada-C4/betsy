class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :item_id
      t.string :status
      t.string :cc_name
      t.string :email_address
      t.string :mailing_address
      t.integer :cc_number
      t.integer :cc_exp
      t.integer :cc_ccv
      t.integer :zip
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
