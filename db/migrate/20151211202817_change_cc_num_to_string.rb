class ChangeCcNumToString < ActiveRecord::Migration
  def change
    change_column :orders, :cc_num, :string
  end
end
