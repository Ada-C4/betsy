require 'rails_helper'

RSpec.describe Order, type: :model do
  let (:good_params) {
    {street: "test" , city: "Seattle", state: "WA", zip: "98116", cc_num: "12345678", cc_cvv: "123", cc_name: "Kelly", cc_exp: "20151215"}
  }

  let (:user_1) { User.create(email: 'nemo@foo.com', name: "Bob", username: "bobi", password: "333", password_confirmation: "333") }
  let (:user_2) { User.create(email: 'nemo1@foo.com', name: "Bob1", username: "bobi1", password: "333", password_confirmation: "333") }
  let (:product_1) { Product.create(name: "Sample", price: 10, stock: 5, user_id: user_1.id) }
  let (:product_2) { Product.create(name: "Sample1", price: 15, stock: 5, user_id: user_2.id) }
  let (:order_item_1) { OrderItem.create(product_id: product_1.id, quantity: 3, shipped: false) }
  let (:order_item_2) { OrderItem.create(product_id: product_2.id, quantity: 2, shipped: true) }
  let (:order_1) { Order.create(good_params.merge(email: "email1@email.com", order_items: [order_item_1], status: "paid")) }
  let (:order_2) { Order.create(good_params.merge(email: "email1@email.com", order_items: [order_item_2], status: "complete")) }

  describe ".validates" do
    it { is_expected.to validate_length_of(:zip) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:street) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:zip) }
    it { is_expected.to validate_presence_of(:cc_num) }
    it { is_expected.to validate_presence_of(:cc_exp) }
    it { is_expected.to validate_presence_of(:cc_cvv) }
    it { is_expected.to validate_presence_of(:cc_name) }

    it "must have a valid email " do
      expect(Order.create(good_params.merge(email: "user_at_foo.org"))).to_not be_valid
      expect(Order.create(good_params.merge(email: "example.user@foo."))).to_not be_valid
      expect(Order.create(good_params.merge(email: "foo@bar_baz.com"))).to_not be_valid
      expect(Order.create(good_params.merge(email: "foo@bar+baz.com"))).to_not be_valid
      expect(Order.create(good_params.merge(email: " "))).to_not be_valid
      expect(Order.create(good_params.merge(email: "kelly@kelly.com"))).to be_valid
    end
  end

  describe "#total_cost" do
    let(:order_item) { FactoryGirl.create(:orderitem) }

    it "calculates the total for an order" do
      order = order_item.order
      item_price = order_item.product.price
      quantity = order_item.quantity
      total = order.total_cost
      expect(total).to eq item_price * quantity
    end
  end

  describe ".user_orders_revenue" do

    it "calculates a user's revenue from a collection of orders" do
      orders = [order_1, order_2]
      expect(Order.user_orders_revenue(orders, user_1)).to eq(30)
    end
  end

  describe '.filter_orders' do
    it "returns orders with a status matching the status parameter" do
      orders = [order_1, order_2]
      expect(Order.filter_orders(orders, "paid").length).to eq 1
      expect(Order.filter_orders(orders, "paid")[0].id).to eq order_1.id
    end
  end
end
