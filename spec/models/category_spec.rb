require 'rails_helper'

RSpec.describe Category, type: :model do
  describe ".validates" do
    it "must have a name" do
      expect(Category.new(name: nil)).to_not be_valid
    end
    it "name must be unique" do
      Category.create(name:"a")
      expect(Category.new(name: "a")).to_not be_valid
    end
    it "name can have 15 characters" do
      expect(Category.new(name: "a" * 15)).to be_valid
    end
    it "name cannot have 16 characters" do
      expect(Category.new(name: "a" * 16)).to_not be_valid
    end
  end
end
