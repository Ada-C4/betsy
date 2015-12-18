class RemoveCategoryId < ActiveRecord::Migration
  def change
    remove_column :products, :cat_id
  end
end
