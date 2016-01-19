require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:review_valid) { Review.new(product_id: 1, rating: 5) }

  describe ".validates" do
    it "must have a product id" do
      review = Review.new(rating: 5)
      expect(review).to_not be_valid
      expect(review.errors.keys).to include :product_id
      expect(review_valid).to be_valid
    end

    it "must have a rating" do
      review = Review.new(product_id: 2)
      expect(review).to_not be_valid
      expect(review.errors.keys).to include :rating
    end

    it "must have a rating > 0 and less than or equal to 5" do
      review = Review.new(product_id: 2, rating: 6)
      expect(review).to_not be_valid
      expect(review.errors.keys).to include :rating
      review = Review.new(product_id: 2, rating: 0)
      expect(review).to_not be_valid
      expect(review.errors.keys).to include :rating
    end
  end
end
