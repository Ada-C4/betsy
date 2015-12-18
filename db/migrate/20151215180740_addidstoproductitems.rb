class Addidstoproductitems < ActiveRecord::Migration
  def change
    add_column :product_items, :orderitem_id, :integer
    add_column :product_items, :product_id, :integer
  end
end
