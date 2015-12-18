class CreateRobots < ActiveRecord::Migration
  def change
    create_table :robots do |t|
      t.string :username
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
