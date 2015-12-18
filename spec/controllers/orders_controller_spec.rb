require 'rails_helper'
require 'pry'

RSpec.describe OrdersController, type: :controller do
  before :each do
    @current_robot = Robot.create(username: "robo", email: "robo@email.com", password: "BestPosswordOfAll")
    session[:robot_id] = @current_robot.id
  end

  describe "GET 'index'" do
    it "is successful" do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe "DELETE 'destroy'" do
    let(:order) do
      Order.create(status: "pending")
    end

    before(:each) do
      session[:order_id] = order.id
    end

    it "redirects to index view" do
      delete :destroy, id: order.id
      expect(subject).to redirect_to orders_path
    end
  end

  describe "confirm" do
    let(:order) do
      Order.create
    end

    let(:good_params) do
      {
        order: {
          credit_name: "Jenna",
          email: "j@example.com",
          credit_num: "1111111111111111",
          cvv: "111",
          address: "123 Fake St.",
          city: "Anytown",
          state: "WA",
          zip: "12345"
        },
      }
    end

    let(:bad_params) do
      {
        order: {
          credit_name: "Jenna",
        },
      }
    end

    before(:each) do
      session[:order_id] = order.id
      @product = Product.create(name: 'something', price: 200, robot_id: 1, stock: 5)
      @orderitem = Orderitem.create(order_id: order.id, product_id: @product.id, quantity: 2)
    end

    it "redirects to confirmation page when successful" do
      patch :confirm, good_params
      expect(subject).to render_template(:confirm)
    end

    it "renders checkout page when unsuccessful" do
      patch :confirm, bad_params
      expect(subject).to render_template(:checkout)
    end
  end

  describe "PATCH 'cancel'" do
    let(:order) do
      Order.create(status: "Awaiting confirmation")
    end

    before(:each) do
      session[:order_id] = order.id
    end

    let(:product) do
      Product.create(name: 'something', price: 200, robot_id: 1, stock: 5)
    end

    let(:orderitem) do
      Orderitem.create(order_id: order.id, product_id: product.id, quantity: 3)
    end

    it "refreshes the page on success" do
      patch :cancel
      expect(subject).to redirect_to orders_path
    end
  end

  describe "PATCH 'finalize'" do
    let(:order) do
      Order.create(status: "Awaiting confirmation")
    end

    before(:each) do
      session[:order_id] = order.id
      @product = Product.create(name: 'something', price: 200, robot_id: 1, stock: 5)
      @orderitem = Orderitem.create(order_id: order.id, product_id: @product.id, quantity: 3)
    end

    it "goes to the thanks page" do
      patch :finalize
      expect(subject).to render_template :thanks
    end

    it "reduces stock" do
      patch :finalize
      expect(Product.find(@product.id).stock).to eq 2
    end

    it "goes back to the cart on failure" do
      patch :finalize
      patch :finalize
      expect(subject).to redirect_to orders_path
    end
  end

  describe "GET 'info'" do
    before(:each) do
      @order = Order.create(status: "paid", email: "test@test.com", address: "test", city: "test", state: "WA", zip: "98102", credit_name: "test", credit_num: "4444444444444444", cvv: "444")

    end

    it "is successful" do
      get :info, id: @order.id
      expect(response.status).to eq 200
    end
  end

  describe "GET 'fulfill'" do
    before(:each) do
      @order = Order.create(status: "paid", email: "test@test.com", address: "test", city: "test", state: "WA", zip: "98102", credit_name: "test", credit_num: "4444444444444444", cvv: "444")
      @product = Product.create(name: 'something', price: 200, robot_id: @current_robot.id, stock: 5)
      @orderitem = Orderitem.create(order_id: @order.id, product_id: @product.id, quantity: 2)
      @current_robot.products.first.orderitems << @orderitem
    end

    it "is successful" do
      get :fulfill, robot_id: @current_robot.id
      expect(response.status).to eq 200
    end
  end
end
