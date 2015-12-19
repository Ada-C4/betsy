require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  before(:each) do
    # must be logged in as merchant
    merchant.authenticate(session_data)
    session[:user_id] = merchant.id
    # merchant must own the product
    product
  end

  let(:orderitem) do
    OrderItem.create(quantity: 3, order_id: 1, product_id: 1, status: "shipped")
  end

  let(:params) do
    { id: 1 }
  end

  let(:merchant) do
    Merchant.create(username: "Seabay", email: "info@seabay.com", password: "password", password_confirmation: "password")
  end

  let(:session_data) do
    {
      username: "Seabay",
      password: "password"
    }
  end

  let(:product) do
    Product.create(name: "starfish", price: 3.00, merchant_id: 1, description: "A starfish!")
  end

  let(:order_item_update) do
    {
      id: 1,
      merchant_id: 1,
      order_item: {
        status: "shipped"
      }
    }
  end

  describe "GET 'edit'" do
    it "renders edit template" do
      get :edit, id: orderitem.id, merchant_id: merchant.id
      expect(response.status).to eq 200
      expect(subject).to render_template :edit
    end
  end

  describe "PATCH 'edit'" do
    it "redirects to merchant orders page after updating" do
      orderitem

      patch :update, order_item_update
      expect(response.status).to eq 302
      expect(subject).to redirect_to merchant_orders_path(merchant.id)
    end
  end
end
