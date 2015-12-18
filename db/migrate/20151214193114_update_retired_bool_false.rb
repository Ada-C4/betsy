class UpdateRetiredBoolFalse < ActiveRecord::Migration
  def change
    change_column_default :products, :retire, false
  end
end
