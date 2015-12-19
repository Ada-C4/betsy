class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :quanitity

      t.timestamps null: false
    end
  end
end
