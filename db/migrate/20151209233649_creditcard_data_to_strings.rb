class CreditcardDataToStrings < ActiveRecord::Migration
  def change
    remove_column :orders, :cc_cvv, :integer
    remove_column :orders, :cc_exp, :integer
    add_column :orders, :cc_exp, :string
    add_column :orders, :cc_cvv, :string
  end
end
