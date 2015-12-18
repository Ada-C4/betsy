require 'rails_helper'

RSpec.describe Orderitem, type: :model do
  let(:product) do
    Product.create(name: 'product', price: 10, robot_id: 1, stock: 100)
  end

  let(:good_orderitem) do
    Orderitem.new(quantity: 10, product_id: product.id, order_id: 1)
  end

  describe "validations" do
    let(:missing_product_id) do
      Orderitem.new(quantity: 1, product_id: nil, order_id: 1)
    end

    let(:missing_quantity) do
      Orderitem.new(quantity: nil, product_id: product.id, order_id: 1)
    end

    let(:missing_order_id) do
      Orderitem.new(quantity: 10, product_id: product.id)
    end

    let(:negative_quantity) do
      Orderitem.new(quantity: 0, product_id: product.id, order_id: 1)
    end

    let(:exceeds_stock) do
      Orderitem.new(quantity: 500, product_id: product.id, order_id: 1)
    end

    it "has a product id" do
      expect(good_orderitem).to be_valid
      expect(missing_product_id).to be_invalid
    end

    it "has a quantity" do
      expect(good_orderitem).to be_valid
      expect(missing_quantity).to be_invalid
    end

    it "has a order_id" do
      expect(good_orderitem).to be_valid
      expect(missing_order_id).to be_invalid
    end

    it "quantity must be greater than 0" do
      expect(good_orderitem).to be_valid
      expect(negative_quantity).to be_invalid
    end

    it "cannot exceed present stock" do
      expect(good_orderitem).to be_valid
      expect(exceeds_stock).to be_invalid
    end

  end
end
