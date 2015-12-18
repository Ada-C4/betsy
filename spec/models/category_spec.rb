require 'rails_helper'

RSpec.describe Category, type: :model do
  let (:category) { FactoryGirl.create(:category) }

  describe ".validates" do
    it { is_expected.to validate_presence_of(:name) }
    it "must have a unique name" do
      expect(Category.new(name: category.name)).to_not be_valid
      expect(Category.new(name: "babied sunscreen")).to be_valid
    end

    it "downcases name before saving" do
      expect(Category.new(name: category.name.upcase)).to_not be_valid
    end

  end

end
