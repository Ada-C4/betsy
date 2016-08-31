class AddRetireToProducts < ActiveRecord::Migration
  def change
    add_column :products, :retire, :boolean
  end
end
