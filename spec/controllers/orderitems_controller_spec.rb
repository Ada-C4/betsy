require 'rails_helper'

RSpec.describe OrderitemsController, type: :controller do
  describe "POST 'add_to_cart'" do
    let(:good_params) do
      {
        orderitem: {
          quantity: 5
        },
        id: 2
      }
    end
    it "redirects to show view" do
      post :add_to_cart, good_params
      expect(subject).to redirect_to product_path(2)
    end
  end

  describe "PATCH 'add_to_cart'" do
    let(:good_params) do
      {
        orderitem: {
          quantity: 5
        },
        id: 2
      }
    end

    it "redirects to show view" do
      post :add_to_cart, good_params
      patch :add_to_cart, good_params
      expect(subject).to redirect_to product_path(2)
    end
  end

  describe "PATCH 'increase_quantity'" do
    let(:order) do
      Order.create(status: "pending")
    end

    before(:each) do
      request.env["HTTP_REFERER"] = "where_i_came_from"
      session[:order_id] = order.id
    end

    let(:product) do
      Product.create(name: 'something', price: 200, robot_id: 1, stock: 5)
    end

    let(:orderitem) do
      Orderitem.create(order_id: order.id, product_id: product.id, quantity: 3)
    end

    it "refreshes the page on success" do
      patch :increase_quantity, id: orderitem.product_id
      expect(subject).to redirect_to "where_i_came_from"
    end

    it "refreshes the page on failure" do
      patch :increase_quantity, id: orderitem.product_id
      patch :increase_quantity, id: orderitem.product_id
      patch :increase_quantity, id: orderitem.product_id
      expect(subject).to redirect_to "where_i_came_from"
    end
  end

  describe "PATCH 'decrease_quantity'" do
    let(:order) do
      Order.create(status: "pending")
    end

    before(:each) do
      request.env["HTTP_REFERER"] = "where_i_came_from"
      session[:order_id] = order.id
    end

    let(:orderitem) do
      Orderitem.create(order_id: order.id, product_id: 2, quantity: 3)
    end

    it "refreshes the page on success" do
      patch :decrease_quantity, id: orderitem.product_id
      expect(subject).to redirect_to "where_i_came_from"
    end

    it "refreshes the page on failure" do
      patch :decrease_quantity, id: orderitem.product_id
      patch :decrease_quantity, id: orderitem.product_id
      patch :decrease_quantity, id: orderitem.product_id
      expect(subject).to redirect_to "where_i_came_from"
    end
  end

  describe "DELETE 'remove'" do
    let(:order) do
      Order.create(status: "pending")
    end

    before(:each) do
      request.env["HTTP_REFERER"] = "where_i_came_from"
      session[:order_id] = order.id
    end

    let(:orderitem) do
      Orderitem.create(order_id: order.id, product_id: 2, quantity: 3)
    end

    it "refreshes the page" do
      delete :remove, id: orderitem.product_id
      expect(subject).to redirect_to "where_i_came_from"
    end
  end

  describe "GET 'ship'" do
    before(:each) do
      request.env["HTTP_REFERER"] = "where_i_came_from"
    end

    let(:orderitem) do
      Orderitem.create(order_id: 1, product_id: 2, quantity: 3, shipped: false)
    end

    it "reverses the shipped status" do
      patch :ship, id: orderitem.id
      expect(orderitem.shipped).to eq false
    end
  end
end
