class ChangeCcvToCvv < ActiveRecord::Migration
  def change
    remove_column :orders, :cc_ccv, :integer
    add_column :orders, :cc_cvv, :integer
  end
end
