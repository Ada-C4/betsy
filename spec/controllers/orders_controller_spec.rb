require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe "GET 'checkout'" do
    it "renders the checkout template" do
      get :checkout
      expect(response).to render_template :checkout
    end

    describe "inventory/quantity conflict error messages" do

      it "provides the gramatically-correct error message if the item quantity is greater than the product inventory" do
        order = Order.create(status: "pending")
        p1 = Product.create(name: "test thing2", price: 10, merchant_id: 1, description: "hi", photo_url: "www.google.com", inventory: 1)
        @order_item = OrderItem.create(quantity: 1, product_id: p1.id , order_id: order.id)
        p1.inventory = 0
        p1.save
        session[:order_id] = order.id
        get :checkout
        expect(flash[:error]).to be_truthy
      end

      it "provides the gramatically-correct error message if the item quantity is greater than the product inventory" do
        order = Order.create(status: "pending")
        p1 = Product.create(name: "test thing3", price: 10, merchant_id: 1, description: "hi", photo_url: "www.google.com", inventory: 4)
        @order_item = OrderItem.create(quantity: 2, product_id: p1.id , order_id: order.id)
        p1.inventory = 1
        p1.save
        session[:order_id] = order.id
        get :checkout
        expect(flash[:error]).to be_truthy
      end

      it "provides the gramatically-correct error message if the item quantity is greater than the product inventory" do
        order = Order.create(status: "pending")
        p1 = Product.create(name: "test thing4", price: 10, merchant_id: 1, description: "hi", photo_url: "www.google.com", inventory: 4)
        @order_item = OrderItem.create(quantity: 3, product_id: p1.id , order_id: order.id)
        p1.inventory = 2
        p1.save
        session[:order_id] = order.id
        get :checkout
        expect(flash[:error]).to be_truthy
      end
    end
  end

  describe "POST 'confirmation'" do
    let (:good_params) do
      {
        order:{
          customer_name: "Minerva McGonagall", customer_email: "miverva@hogwarts.com", street_address: "Hogwarts Castle", zip_code: 12345, state: "Washington", city: "Hogwarts", card_number: 1234567812345678, customer_card_exp_month: 10, customer_card_exp_year: 2018, security_code: 123, name_on_card: "Minerva McGonagall", billing_zip_code: 12345
        }
      }
    end

    let (:bad_params) do
      {
        order:{
          status: "pending", order_time: Time.now, customer_name: "Minerva McGonagall", customer_email: "miverva@hogwarts.com", street_address: "Hogwarts Castle", zip_code: 12345, state: "Washington", city: "Hogwarts", card_number: 1234, customer_card_exp_month: 10, customer_card_exp_year: 2018, security_code: 1, name_on_card: "Minerva McGonagall"
        }
      }
    end

    before (:each) do
      order = Order.create(status: "pending")
      Product.create(name: "magic stuff", price: 10, merchant_id: 1, description: "hi", photo_url: "www.google.com", inventory: 4)
      @order_item = OrderItem.create(quantity: 1, product_id: 1, order_id: order.id)
      session[:order_id] = order.id
    end

    it "renders the confirmation template if validations pass" do
      post :confirmation, good_params
      expect(response).to render_template :confirmation
    end

    it "renders the checkout page if validations do not pass" do
      post :confirmation, bad_params
      expect(response).to render_template :checkout
    end

    it "updates inventory if validations pass" do
      post :confirmation, good_params
      expect(@order_item.product.inventory).to eq 3
    end
  end

  describe "GET 'cart'" do
    it "renders the cart template" do
      get :cart
      expect(response).to render_template :cart
    end
  end

  describe "Logged in functions" do
    before (:each) do
      merchant = Merchant.create(user_name: "Hailey", email: "spiderlover222@hogwarts.com", password: "123", password_confirmation: "123")
      product = Product.create(name: "test thing19", price: 10, merchant_id: merchant.id, description: "hi", photo_url: "www.google.com", inventory: 4)
      @order = Order.create(status: "pending", order_time: Time.now, customer_name: "Minerva McGonagall", customer_email: "miverva@hogwarts.com", street_address: "Hogwarts Castle", zip_code: 12345, state: "Washington", city: "Hogwarts", card_number: 1234, customer_card_exp_month: 10, customer_card_exp_year: 2018, security_code: 123, name_on_card: "Minerva McGonagall" )
      order_item = OrderItem.create(quantity: 1, product_id: product.id, order_id: @order.id)
      session[:merchant_id] = merchant.id
    end

    describe "GET #show" do
      it "renders the show template if there are items in the order that belong to the merchant" do
        get :show, id: @order.id
        expect(subject).to render_template :show
      end
    end
  end
end
