require 'rails_helper'

RSpec.describe Review, type: :model do

  describe "model validations" do
    it "requires a value" do
      empty_item = Review.new
      expect(empty_item).to be_invalid
      expect(empty_item.errors.keys).to include :rating
    end
  end
  # does not work - fix!
  describe "model validations for integer input" do
    it "requires an integer between 1-5" do
      review = Review.new(rating: "")
        expect(review).to be_invalid
        expect(review.errors.keys).to include(:rating)
    end
  end



end
