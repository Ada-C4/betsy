require 'rails_helper'
require 'pry'

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
    it "renders the index view" do
      get :index, user_id: user.id
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
      binding.pry
      expect(subject).to redirect_to user_orders_path(user.id)
    end

  end

end
