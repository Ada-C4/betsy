require 'rails_helper'

RSpec.describe Review, type: :model do
  before :each do
    @good_review = Review.create(product_id: 1, rating: 5)
    @bad_review = Review.create(product_id: nil, rating: nil)
    @negative_nums = Review.create(product_id: 1, rating: -1)
    @high_nums = Review.create(product_id: 1, rating: 10)
  end

  describe "validations" do 
    it "good is good and bad is bad" do 
      expect(@good_review).to be_valid
      expect(@bad_review).to_not be_valid
    end

    it "has a rating" do
      expect(@bad_review.errors.keys).to include(:rating)
    end

    it "has a product_id" do
      expect(@bad_review.errors.keys).to include(:product_id)
    end

    it "rating must be greater than 0 and less than five" do
      expect(@negative_nums.errors.keys).to include(:rating)
      expect(@high_nums.errors.keys).to include(:rating)
    end
  end
end
