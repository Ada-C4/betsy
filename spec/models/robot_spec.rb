require 'rails_helper'

RSpec.describe Robot, type: :model do
  describe "validations" do 

    it "requires name" do 
    end

    it "requires name as case sensitive" do 
    end

    it "requires unique email" do 
    end

    it "requires password confirmation to match" do 
    end
  end

  describe "revenue method" do 
    it "calculates the revenue" do 
      @robot = Robot.create(username: 'test', email: 'test@test.com', password: 'test', password_confirmation: 'test')
      @product = Product.create(name: 'test', price: 10, robot_id: @robot.id, stock: 1)
      @order = Order.create(status: "paid")
      @orderitem = Orderitem.create(product_id: @product.id, order_id: @order.id, quantity: 1)

      expect(@robot.revenue).to eq 10
    end
  end
end
