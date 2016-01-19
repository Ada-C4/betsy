require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product_valid) { Product.new(name: "test", price: 20, user_id: 3, inventory_total: 0, image_url: "http://1.bp.blogspot.com/-cXddk5QHswo/UUrwsdxVGOI/AAAAAAAACpA/RP1Xbavhn9w/s1600/Flying+-Birds-+(6).jpg" )}

  describe ".validates" do
    it "must have a name" do
      product = Product.new(price: 30, user_id: 2, inventory_total: 1, image_url: "http://1.bp.blogspot.com/-cXddk5QHswo/UUrwsdxVGOI/AAAAAAAACpA/RP1Xbavhn9w/s1600/Flying+-Birds-+(6).jpg")
      expect(product).to_not be_valid
      expect(product.errors.keys).to include :name
      expect(product_valid).to be_valid
    end

    it "must have a price" do
      product = Product.new(name:"test",user_id: 2, inventory_total: 1, image_url: "http://1.bp.blogspot.com/-cXddk5QHswo/UUrwsdxVGOI/AAAAAAAACpA/RP1Xbavhn9w/s1600/Flying+-Birds-+(6).jpg")
      expect(product).to_not be_valid
      expect(product.errors.keys).to include :price
    end

    it "must have a user id" do
      product = Product.new(price: 30, name:"test", inventory_total: 1, image_url: "http://1.bp.blogspot.com/-cXddk5QHswo/UUrwsdxVGOI/AAAAAAAACpA/RP1Xbavhn9w/s1600/Flying+-Birds-+(6).jpg")
      expect(product).to_not be_valid
      expect(product.errors.keys).to include :user_id
    end

    it "must have a unique name" do
      product_first = Product.new(name: "test", price: 30, user_id: 2, inventory_total: 1, image_url: "http://1.bp.blogspot.com/-cXddk5QHswo/UUrwsdxVGOI/AAAAAAAACpA/RP1Xbavhn9w/s1600/Flying+-Birds-+(6).jpg")
      product_first.save
      expect(product_valid).to_not be_valid
      expect(product_valid.errors.keys).to include :name
    end

    it "must have a price greater than 0" do
      product = Product.new(price: -2, user_id: 2, name: "test", inventory_total: 1, image_url: "http://1.bp.blogspot.com/-cXddk5QHswo/UUrwsdxVGOI/AAAAAAAACpA/RP1Xbavhn9w/s1600/Flying+-Birds-+(6).jpg")
      expect(product).to_not be_valid
      expect(product.errors.keys).to include :price
    end

    it "must have an inventory total" do
      product = Product.new(price: 200, user_id: 2, name: "test", image_url: "http://1.bp.blogspot.com/-cXddk5QHswo/UUrwsdxVGOI/AAAAAAAACpA/RP1Xbavhn9w/s1600/Flying+-Birds-+(6).jpg")
      expect(product).to_not be_valid
      expect(product.errors.keys).to include :inventory_total
    end

    it "must have an non-negative inventory" do
      product = Product.new(price: 200, user_id: 2, name: "test", inventory_total: -4, image_url: "http://1.bp.blogspot.com/-cXddk5QHswo/UUrwsdxVGOI/AAAAAAAACpA/RP1Xbavhn9w/s1600/Flying+-Birds-+(6).jpg")
      expect(product).to_not be_valid
      expect(product.errors.keys).to include :inventory_total
    end

    it "must have a product image URL" do
      product = Product.new(price: 200, user_id: 2, name: "test", inventory_total: 3)
      expect(product).to_not be_valid
      expect(product.errors.keys).to include :image_url
    end

    it "the image URL must be a valid URL" do
      product = Product.new(price: 200, user_id: 2, name: "test", inventory_total: 3, image_url: "dog")
      expect(product).to_not be_valid
      expect(product.errors.keys).to include :image_url
    end
  end

  describe ".average_rating" do
    before(:each) do
      @product = Product.create(price: 200, user_id: 1, name: "test", inventory_total: 3, image_url:  "http://1.bp.blogspot.com/-cXddk5QHswo/UUrwsdxVGOI/AAAAAAAACpA/RP1Xbavhn9w/s1600/Flying+-Birds-+(6).jpg")
      @review1 = Review.create(product_id: 1, rating: 5)
      @review2 = Review.create(product_id: 1, rating: 3)
    end

    it "calculates the correct average rating for a product" do
      expect(@product.average_rating).to eq 4
    end
  end
end
