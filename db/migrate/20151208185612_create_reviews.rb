class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.string :review_text
      t.integer :product_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
