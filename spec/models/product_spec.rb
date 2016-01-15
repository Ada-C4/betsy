require 'rails_helper'
require 'pry'

RSpec.describe Product, type: :model do
  let(:good_hash) do
    {name: "Geometry Like Woah",
     price: 5645245,
     user_id: "2",
     stock: "1",
     photo_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDeCvOq-lfd-xau5kCj_RZ5WOD1wldXJybYd9abKVYwZKaGAay",
     description: "I drew this just for you.",
     retired: false
   }
  end
  let(:second_hash) do
    {name: "Geometry 4",
     price: 5645245,
     user_id: "4",
     stock: "1",
     photo_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDeCvOq-lfd-xau5kCj_RZ5WOD1wldXJybYd9abKVYwZKaGAay",
     description: "I drew this just for you.",
     retired: false
   }
  end
  let(:third_hash) do
    {name: "Geometry 3",
     price: 5645245,
     user_id: "3",
     stock: "1",
     photo_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDeCvOq-lfd-xau5kCj_RZ5WOD1wldXJybYd9abKVYwZKaGAay",
     description: "I drew this just for you.",
     retired: false
   }
  end

  describe ".validates" do

    let (:no_name_hash) do
      {name: nil,
       price: 5645245,
       user_id: "2",
       stock: "1",
       photo_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDeCvOq-lfd-xau5kCj_RZ5WOD1wldXJybYd9abKVYwZKaGAay",
       description: "I drew this just for you."
      }
    end

    let (:no_price_hash) do
      {
       name: "Harry",
       price: nil,
       user_id: "2",
       stock: "1",
       photo_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDeCvOq-lfd-xau5kCj_RZ5WOD1wldXJybYd9abKVYwZKaGAay",
       description: "I drew this just for you."
      }
    end

    let (:price_of_zero) do
      {
        name: "Harry",
        price: 0,
        user_id: "2",
        stock: "1",
        photo_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDeCvOq-lfd-xau5kCj_RZ5WOD1wldXJybYd9abKVYwZKaGAay",
        description: "I drew this just for you."
      }
    end

    let (:price_not_a_number) do
      {
        name: "Harry",
        price: "two dollars",
        user_id: "2",
        stock: "1",
        photo_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDeCvOq-lfd-xau5kCj_RZ5WOD1wldXJybYd9abKVYwZKaGAay",
        description: "I drew this just for you."
      }
    end

    let (:no_user_id_hash) do
      {
        name: "Harry",
        price: 435345,
        user_id: nil,
        stock: "1",
        photo_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDeCvOq-lfd-xau5kCj_RZ5WOD1wldXJybYd9abKVYwZKaGAay",
        description: "I drew this just for you."
      }
    end

    let (:stock_of_negative) do
      {
        name: "Harry",
        price: 435345,
        user_id: "2",
        stock: -1,
        photo_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDeCvOq-lfd-xau5kCj_RZ5WOD1wldXJybYd9abKVYwZKaGAay",
        description: "I drew this just for you."
      }
    end

    let (:retired) do
      {
        name: "Harry",
        price: 435345,
        user_id: "2",
        stock: 0,
        photo_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDeCvOq-lfd-xau5kCj_RZ5WOD1wldXJybYd9abKVYwZKaGAay",
        description: "I drew this just for you.",
        retired: true
      }
    end

    let (:not_retired) do
      {
        name: "Harry",
        price: 435345,
        user_id: "2",
        stock: 0,
        photo_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDeCvOq-lfd-xau5kCj_RZ5WOD1wldXJybYd9abKVYwZKaGAay",
        description: "I drew this just for you.",
        retired: false
      }
    end

    it "must have a name" do
      expect(Product.new(good_hash)).to be_valid
      expect(Product.new(no_name_hash)).to_not be_valid
    end
#
    it "must have a unique name" do
      @test_product = Product.new(good_hash)
      @test_product.save
      expect(@test_product).to be_valid
      expect(Product.new(good_hash)).to_not be_valid
      @test_product.destroy
    end

    it "must have a price" do
      expect(Product.new(no_price_hash)).to_not be_valid
    end

    it "must have a price that is a number" do
      expect(Product.new(price_not_a_number)).to_not be_valid
    end

    it "must have a price greater than zero" do
      expect(Product.new(price_of_zero)).to_not be_valid
    end

    it "has a stock that isn't negative" do
      expect(Product.new(stock_of_negative)).to_not be_valid
    end

    # it "must belong to a User" do
    #   expect(Product.new(no_user_id_hash)).to_not be_valid
    # end

    # it "upon creation is not retired" do
    #   expect(Product.new(retired)).to_not be_valid
    #   expect(Product.new(not_retired)).to be_valid
    # end

    it "is retired with (insert method here to test?)" do
    end

    #test that destroying a product destroys its reviews

  end

  describe "belongs_to_user?" do
    it "" do

    end
  end

  describe "avg_rating" do
    let (:product) do
      product = Product.create(good_hash)
      r1 = Review.create(rating: 1, product_id: product.id)
      r2 = Review.create(rating: 5, product_id: product.id)
      product.reviews << [r1, r2]
      return product
    end

    it "returns an integer" do
      expect(product.avg_rating).to be_a(Integer)
    end

    it "returns average of all ratings of product reviews" do
      expect(product.avg_rating).to eq(3)
    end

    it "returns zero if product has no reviews" do
      expect(Product.create(good_hash).avg_rating).to eq(0)
    end

  end

  describe "self.top_selling(product_array, x)" do
    let(:p)  do
      p = []
      p << Product.create(good_hash)
      p << Product.create(second_hash)
      p << Product.create(third_hash)
      return p
    end
    it  "returns Product instances" do
      expect(Product.top_selling(p, 2)[0]).to be_a(Product)
    end
    it "returns x number of instances"  do
      expect(Product.top_selling(p, 2).length).to eq(2)
      expect(Product.top_selling(p, 1).length).to eq(1)
    end
  end

end
