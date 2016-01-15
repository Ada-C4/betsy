class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.integer :product_id
      t.string :body

      t.timestamps null: false
    end
  end
end
