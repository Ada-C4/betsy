class AddShipColumn < ActiveRecord::Migration
  def change
    add_column :orderitems, :shipped, :boolean, :default => false
  end
end
