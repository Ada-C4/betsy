require 'rails_helper'
require 'pry'
require 'spec_helper'

RSpec.describe OrdersController, type: :controller do

  let(:user) do
    User.create(first_name: "Someone",
                last_name: "Else",
                email: "7@7.co",
                password: "pass",
                password_confirmation: "pass")
  end

  let(:order) do
    Order.create(status: "pending",
                 email: "caprina.keller@test.com",
                 mailing_address: "3158 Union Street,
                 Reisterstown, MD",
                 name_on_card: "Caprina Keller",
                 last_four: "1911",
                 card_exp: Date.today,
                 zip: "22136"
    )
  end

  before :each do
    cookies.signed[:order] = order.id
    product = Product.create(name: "Fuzzy Wah-Wah pedal",
                       description: "Making some glorious vintage guitar sounds",
                       price: 4000,
                       inventory_total: 50,
                       retired: false,
                       image_url: "http://i.ebayimg.com/images/i/251806872987-0-1/s-l1000.jpg",
                       user_id: user.id)
    order_item = OrderItem.create(quantity: 4,
                       product_id: product.id,
                       shipped: false,
                       order_id: order.id)
  end

  describe "GET 'index'" do
    let(:product) do
      Product.create(name: "For Some Was He",
                       description: "A partial judge",
                       price: 40000,
                       inventory_total: 100,
                       retired: false,
                       image_url: "http://vignette4.wikia.nocookie.net/simpsons/images/c/cc/Judge_Roy_Snyder_.png",
                       user_id: user.id)
    end

    let(:order_item) do
      OrderItem.create(quantity: 4,
                       product_id: product.id,
                       shipped: false,
                       order_id: order.id)
    end

    let(:order_item_2) do
      OrderItem.create(quantity: 4,
                       product_id: product.id,
                       shipped: false,
                       order_id: order.id)
    end



    it "renders the index view when there are no orders and a user is signed in" do
      get :index, user_id: user.id
      expect(subject).to render_template :index
    end

    it "renders the index view when there are existing pending orders" do
      get :index, {user_id: user.id, sort: "pending"}
      expect(subject).to render_template :index
    end

    it "renders the index view when there is an order item in an order" do
      get :index, {user_id: user.id, order_id: order.id, order_item_id: order_item.id, order_item_2_id: order_item_2.id}
      expect(subject).to render_template :index
    end

  end

  describe "GET 'show'" do
    it "renders the show page" do
      get :show, id: order.id, user_id: user.id
      expect(subject).to render_template :show
    end
  end

  describe "GET 'checkout'" do

    it "renders checkout view if cart is not empty" do
      get :checkout
      expect(subject).to render_template :checkout
    end

    it "redirects to root path if new order or no in stock items in cart" do
      cookies.signed[:order] = Order.create(status: "pending").id
      get :checkout
      expect(subject).to redirect_to root_path
    end
  end

  describe "PATCH 'update'" do
    let(:params) do
       { order: {
           status: "pending",
           email: "caprina.keller@test.com",
           mailing_address: "3158 Union Street,
           Reisterstown, MD",
           name_on_card: "Caprina Keller",
           last_four: "111111111111911",
           card_exp: Date.today,
           zip: "22136"
         }
        }
    end

    let(:bad_params) do
       { order: {
         status: "pending",
         email: nil,
         mailing_address: "3158 Union Street,
         Reisterstown, MD",
         name_on_card: nil,
         last_four: "111111111111911",
         card_exp: Date.today,
         zip: "22136"
         }
        }
    end

    it "redirects to the confirmation page after including valid info" do
      cookies.signed[:stocked] = order.order_items.length

      patch :update, params.merge(id: order.id)
      expect(subject).to redirect_to confirmation_path
    end

    it "redirects to cart_path if number of instock items changed" do
      cookies.signed[:stocked] = 100000000

      patch :update, params.merge(id: order.id)
      expect(subject).to redirect_to cart_path
    end

    it "redirects to the confirmation page after including valid info" do
      cookies.signed[:stocked] = order.order_items.length

      patch :update, bad_params.merge(id: order.id)
      expect(subject).to render_template :checkout
    end
  end

  describe "PATCH 'ship'" do
    let(:another_user) do
      User.create(first_name: "Mister",
                  last_name: "Man",
                  email: "10@10.co",
                  password: "password",
                  password_confirmation: "password")
    end

    let(:params) do
      {
        user_id: user.id,
        order_id: order.id
      }
    end

    it "redirects to the user order page with order complete" do
      patch :ship, params
      expect(subject).to redirect_to user_orders_path(user.id)
    end

    it "redirects to the user order page without order complete" do
      product = Product.create(name: "Poop",
                         description: "Smelly",
                         price: 40,
                         inventory_total: 5,
                         retired: false,
                         image_url: "http://i.ebayimg.com/images/i/251806872987-0-1/s-l1000.jpg",
                         user_id: another_user.id)
      order_item = OrderItem.create(quantity: 4,
                         product_id: product.id,
                         shipped: false,
                         order_id: order.id)
      patch :ship, params
      expect(subject).to redirect_to user_orders_path(user.id)
    end

  end

  describe "GET 'confirmation'" do
    it "sets the session when one is set" do
      session[:order] = order.id
      get :confirmation
      expect(subject).to render_template :confirmation
    end
    it "renders the confirmation page when a current session is set" do
      get :confirmation
      expect(subject).to render_template :confirmation
    end
  end
end
