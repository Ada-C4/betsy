class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :rating
      t.integer :product_id
      t.string :body

      t.timestamps null: false
    end
  end
end
