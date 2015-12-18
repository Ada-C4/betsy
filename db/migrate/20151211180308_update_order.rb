class UpdateOrder < ActiveRecord::Migration
  def change
    add_column :orders, :email, :string
    add_column :orders, :mailing_address, :string
    add_column :orders, :name_on_card, :string
    add_column :orders, :last_four, :string
    add_column :orders, :card_exp, :date
    add_column :orders, :zip, :string
  end
end
