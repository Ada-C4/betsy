require 'rails_helper'

RSpec.describe Order, type: :model do

  let(:order_valid) { Order.new(status: "test")}

  describe ".validates" do

    it "must have a status" do
      order = Order.new()
      expect(order).to_not be_valid
      expect(order.errors.keys).to include :status
      expect(order_valid).to be_valid
    end
  end


  describe "model methods" do
    before(:each) do
      @test_user_order = User.create(first_name: "Someone",
                      last_name: "Else",
                      email: "7@7.co",
                      password: "pass",
                      password_confirmation: "pass")
      @test_order = Order.create(status: "test")
      @test_product = Product.create(name: "test", price: 20, user_id: 1, inventory_total: 20, image_url: "http://1.bp.blogspot.com/-cXddk5QHswo/UUrwsdxVGOI/AAAAAAAACpA/RP1Xbavhn9w/s1600/Flying+-Birds-+(6).jpg" )
      @test_order_item = OrderItem.create(quantity: 10, order_id: 1, product_id: 1)
    end

    it "total method correctly totals user revenue for an order" do
      user = @test_user_order.id
      order = @test_order
      expect(order.total(user)).to eq 200
    end

    it "adjust_stock adjusts the stock of a product as expected" do
      order = @test_order
      test_product = order.order_items[0].product
      first_item_inventory = test_product.inventory_total
      test_quantity = order.order_items[0].quantity
      order.adjust_stock
      expect(test_product.inventory_total).to eq (first_item_inventory - test_quantity)
    end

  end

end
