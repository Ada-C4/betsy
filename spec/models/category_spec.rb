require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "validations" do 
    it "raises an error when name was missing" do
      bad_category = Category.create

      expect(bad_category).to_not be_valid
      expect(bad_category.errors.keys).to include(:name)
    end

    it "refuses to build category with same name" do 
      Category.create(name: "test")
      Category.create(name: "test")
      Category.create(name: "test")

      expect(Category.all.count).to eq 1
    end
  end
end
