class CcNumberIntoString < ActiveRecord::Migration
  def change
    change_column(:orders, :cc_number, :string)
  end
end
