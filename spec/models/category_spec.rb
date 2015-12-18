require 'rails_helper'

RSpec.describe Category, type: :model do

  describe ".validates" do
    it "must have a name" do
      category = Category.new(name: nil)
      expect(category).to_not be_valid
      expect(category.errors.keys).to include :name
      category_valid = Category.new(name: "Food")
      expect(category_valid).to be_valid
    end

  end
end
