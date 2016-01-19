require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:order_valid) { OrderItem.new(quantity: 10, order_id: 2, product_id: 2) }

  describe ".validates" do
    it "must have a product id" do
      order_item = OrderItem.new(quantity: 10, order_id: 2)
      expect(order_item).to_not be_valid
      expect(order_item.errors.keys).to include :product_id
      expect(order_valid).to be_valid
    end

    it "must have an order id" do
      order_item = OrderItem.new(quantity: 10, product_id: 2)
      expect(order_item).to_not be_valid
      expect(order_item.errors.keys).to include :order_id
    end

    it "must have a quantity" do
      order_item = OrderItem.new(product_id: 2, order_id: 2)
      expect(order_item).to_not be_valid
      expect(order_item.errors.keys).to include :quantity
    end

    it "must have a quantity greater than or equal to 0" do
      order_item = OrderItem.new(product_id: 2, order_id: 2, quantity: -5)
      expect(order_item).to_not be_valid
    end

    it "must have an integer quantity" do
      order_item = OrderItem.new(product_id: 2, order_id: 2, quantity: 2.5)
      expect(order_item).to_not be_valid
    end
  end
end
