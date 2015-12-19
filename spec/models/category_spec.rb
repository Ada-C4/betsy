require 'rails_helper'

RSpec.describe Category, type: :model do
  describe ".validates" do
    it "must have a name" do
      expect(Category.new(name:"name")).to be_valid
      expect(Category.new(name: nil)).to be_invalid
    end
  end
end
