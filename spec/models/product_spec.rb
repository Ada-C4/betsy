require 'rails_helper'

RSpec.describe Product, type: :model do
  before :each do
    @good_product = Product.create(name: 'product', price: 10, robot_id: 1, stock: 1)
    @bad_product = Product.create(name: nil, price: nil, robot_id: nil, stock: nil)
    @negative_nums = Product.create(name: 'product', price: -10, robot_id: 1, stock: -1)
  end

  describe "validations" do
    it "has a user id" do
      expect(@good_product).to be_valid
      expect(@bad_product).to_not be_valid
    end

    it "has a name" do
      expect(@good_product).to be_valid
      expect(@bad_product).to_not be_valid
      expect(@bad_product.errors.keys).to include(:name)
    end

    it "has a robot_id" do
      expect(@bad_product.errors.keys).to include(:robot_id)
    end

    it "has a price" do
      expect(@bad_product.errors.keys).to include(:price)
    end

    it "price must be greater than 0" do
      expect(@negative_nums.errors.keys).to include(:price)
    end

    it "has a stock" do
      expect(@bad_product.errors.keys).to include(:stock)
    end

    it "stock must be greater than 0" do
      expect(@negative_nums.errors.keys).to include(:stock)
    end
  end

  describe "model methods" do
    it "averages the rating correctly" do
      Review.create(rating: 4, product_id: @good_product.id)
      Review.create(rating: 3, product_id: @good_product.id)
      Review.create(rating: 3, product_id: @good_product.id)
      Review.create(rating: 3, product_id: @good_product.id)

      expect(@good_product.rating_average).to eq 3
    end

    it "shows categories correctly" do
      @cat1 = Category.create(name: "cat1")
      @cat2 = Category.create(name: "cat2")
      @cat3 = Category.create(name: "cat3")
      @cat4 = Category.create(name: "cat4")

      Product.find(@good_product.id).categories << Category.find(@cat1.id)
      Product.find(@good_product.id).categories << Category.find(@cat2.id)
      Product.find(@good_product.id).categories << Category.find(@cat3.id)
      Product.find(@good_product.id).categories << Category.find(@cat4.id)

      expect(@good_product.show_categories).to eq "Cat1, Cat2, Cat3, Cat4"
    end

    it "searches products and descriptions for a word" do
      expect(Product.search("product").name).to eq (@good_product.name.titlecase)
    end
  end
end
