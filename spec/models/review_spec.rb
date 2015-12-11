require 'rails_helper'

RSpec.describe Review, type: :model do
  describe ".validates" do
    it { is_expected.to validate_presence_of(:rating) }
    it "requires a rating in correct range" do
      expect(Review.new(rating: 5)).to be_valid
      expect(Review.new(rating: 0)).to be_invalid
      expect(Review.new(rating: 6)).to be_invalid
    end
  end

end
