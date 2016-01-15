class Puttingpassworddigestinuser < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
    remove_column :users, :password, :string
    remove_column :users, :password_confirmation, :string
  end
end
