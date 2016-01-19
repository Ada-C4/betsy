require 'rails_helper'

RSpec.describe User, type: :model do

  let(:password) { BCrypt::Password.create("password") }

  let(:user_valid) { User.new(email: "test@test.com", password: password, first_name: "Jessica", last_name: "Test") }

  describe ".validates" do

    it "must have a email" do
      user = User.new(password: password, first_name: "Jessica", last_name: "Test")
      expect(user).to_not be_valid
      expect(user.errors.keys).to include :email
      expect(user_valid).to be_valid
    end

    it "must have a unique email" do
      user_first = User.new(email:"test@test.com", password: password, first_name: "Jessica", last_name: "Test")
      user_first.save
      expect(user_valid).to_not be_valid
      expect(user_valid.errors.keys).to include :email
    end

    it "must have a valid email format" do
      user = User.new(password: password, email: "test", first_name: "Jessica", last_name: "Test")
      expect(user).to_not be_valid
      expect(user.errors.keys).to include :email
    end
  end




  describe "user model methods" do
    before(:each) do
      @test_user_user ||= User.create(first_name: "Someone",
                      last_name: "Else",
                      email: "7@7.co",
                      password: "pass",
                      password_confirmation: "pass")
      @order1 ||= Order.create( status: "test" )
      @order2 ||= Order.create( status: "test2" )
      @product1 ||= Product.create(price: 200, user_id: 1, name: "test", inventory_total: 2, image_url: "http://1.bp.blogspot.com/-cXddk5QHswo/UUrwsdxVGOI/AAAAAAAACpA/RP1Xbavhn9w/s1600/Flying+-Birds-+(6).jpg")
      @product2 ||= Product.create(price: 200, user_id: 1, name: "test2", inventory_total: 2, image_url: "http://1.bp.blogspot.com/-cXddk5QHswo/UUrwsdxVGOI/AAAAAAAACpA/RP1Xbavhn9w/s1600/Flying+-Birds-+(6).jpg")
      @order_item1 ||= OrderItem.create(quantity: 10, order_id: 1, product_id: 1)
      @order_item2 ||= OrderItem.create(quantity: 10, order_id: 2, product_id: 1)
      @order_item3 ||= OrderItem.create(quantity: 20, order_id: 1, product_id: 1)
      @user = @test_user_user
    end

    it "must report accurate revenue" do
      expect(@user.revenue).to eq 8000
    end

    it "must report accurate revenue by status" do
      expect(@user.revenue_by_status("test")).to eq 6000
    end

    it "must report an accurate number of orders" do
      expect(@user.num_orders).to eq 2
    end

    it "must report an accurate number of orders by status" do
      expect(@user.num_orders_by_status("test")).to eq 1
    end

    it "must find an order item for a given order" do
      expect(@user.find_order_item(@order1)).to eq false
    end
  end
end
