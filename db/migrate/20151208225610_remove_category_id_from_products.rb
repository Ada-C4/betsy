class RemoveCategoryIdFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :category_id, :integer
  end
end
