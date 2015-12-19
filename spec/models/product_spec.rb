require 'rails_helper'

RSpec.describe Product, type: :model do

  empty_product = Product.new

  let(:good_product) do
  Product.create({
      name: "Dolphin",
      price: 2,
      description: "description"
    })
  end

  describe "model validations" do
    it "requires that a product name be present" do
      expect(empty_product).to be_invalid
      expect(empty_product.errors.keys).to include :name
    end

    it "requires that a product have a unique name" do
      good_product
      dup_product = good_product.dup
      dup_product.save
      expect(dup_product).to_not be_valid
      expect(dup_product.errors[:name]).to include("has already been taken")
    end

    it "requires that the price is present" do
      expect(empty_product).to be_invalid
      expect(empty_product.errors.keys).to include(:price)
    end

    it "expects price to be an integer" do
      bad_price = Product.create({ name: "Dolphin", price: "a", description: "description"})
      expect(bad_price).to be_invalid
      expect(bad_price.errors.keys).to include (:price)
    end
    it "expects price to be greater than 0" do
      bad_price = Product.create({ name: "Dolphin", price: 0, description: "description"})
      expect(bad_price).to be_invalid
      expect(bad_price.errors.keys).to include (:price)
    end
  end
end
