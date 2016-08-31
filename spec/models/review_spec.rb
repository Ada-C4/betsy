require 'rails_helper'

RSpec.describe Review, type: :model do
  describe ".validates" do
    it "rating must be present" do
      expect(Review.new(product_id: 1, description: "a")).to_not be_valid
    end
    it "rating must be an integer" do
      expect(Review.new(rating: "a", product_id: 1, description: "a")).to_not be_valid
    end
    it "rating cannot be 0" do
      expect(Review.new(rating: 0, product_id: 1, description: "a")).to_not be_valid
    end
    it "rating cannot be 6" do
      expect(Review.new(rating: 6, product_id: 1, description: "a")).to_not be_valid
    end
    it "rating can be 1" do
      expect(Review.new(rating: 1, product_id: 1, description: "a")).to be_valid
    end
    it "rating can be 5" do
      expect(Review.new(rating: 5, product_id: 1, description: "a")).to be_valid
    end
  end
end
