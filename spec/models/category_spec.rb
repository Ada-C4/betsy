require 'rails_helper'

RSpec.describe Category, type: :model do

  describe ".validates" do
    it "must have a name" do
      expect(Category.new(name: nil)).to_not be_valid
    end

    it "must have a unique name" do
      @test_category = Category.new(name: "Birthstone")
      @test_category.save
      expect(@test_category).to be_valid
      expect(Category.new(name: "Birthstone")).to_not be_valid
      @test_category.destroy
    end
  end

  describe "top(x)" do
    let(:product_hash) do
       {name: "Geometry Like Woahhh",
        price: 5645245,
        stock: "1",
        photo_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDeCvOq-lfd-xau5kCj_RZ5WOD1wldXJybYd9abKVYwZKaGAay",
        description: "I drew this just for you.",
        retired: false
      }
    end
    let(:second_product) do
       {name: "Another Product Thing",
        price: 5645245,
        stock: "2",
        photo_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDeCvOq-lfd-xau5kCj_RZ5WOD1wldXJybYd9abKVYwZKaGAay",
        description: "I drew this just for you.",
        retired: false
      }
    end
    let(:category) do
      category = Category.create(name: "Some Stuff")
      p = Product.create(product_hash)
      p2 = Product.create(second_product)
      category.products << [p, p2]
      return category
    end
    it "returns product instances" do
      expect(category.top(2)[0]).to be_a(Product)
    end
    it "returns x products" do
      expect(category.top(1).length).to eq(1)
      expect(category.top(2).length).to eq(2)
    end
  end
end
