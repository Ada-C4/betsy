require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

  let (:product) { FactoryGirl.create(:product) }

  let (:good_params) {
    { user_id: product.user.id,
      order: { email: "Kelly@kelly.com", street: "test" , city: "Seattle", state: "WA", zip: "98116", cc_num: "123", cc_cvv: "123", cc_name: "Kelly", cc_exp: "20151215"}
    }
  }

  let (:order) { Order.create(good_params[:order].merge(status: "paid")) }

  let (:bad_params) {
    { user_id: product.user.id,
      order: { zip: "zzz" }
    }
  }

  describe "GET 'index'" do
    it "is successful" do
      session[:user_id] = product.user.id
      get :index, user_id: product.user.id
      expect(response.status).to eq 200
    end
  end

  describe "GET 'show'" do
    it "renders the show view" do
      sample_order = Order.create(good_params[:order])
      get :show, id: sample_order.id, user_id: product.user.id
      expect(subject).to render_template :show
    end
  end

  describe "GET 'new'" do
    it "renders new view when there's enough stock" do
      session[:cart] = { product.id => 2 }
      get :new, user_id: product.user.id
      expect(subject).to render_template :new
    end

    it "redirects to cart page when there's not enough stock" do
      session[:cart] = { product.id => 11 }
      get :new, user_id: product.user.id
      expect(subject).to redirect_to cart_path
    end
  end

  describe "POST 'create'" do
    it "redirects to checkout confirmation page" do
      session[:cart] = { product.id => 2 }
      session[:user_id] = product.user.id
      post :create, good_params
      expect(subject).to redirect_to confirmation_path
    end

    it "renders new template on error" do
      session[:cart] = { product.id => 2 }
      post :create, bad_params
      expect(subject).to render_template :new
    end
  end

  describe "GET 'confirm'" do
    it "is successful with an order_id in the session" do
      session[:order_id] = order.id
      get :confirm
      expect(response.status).to eq 200
    end

    it "redirects to home page if no order_id is in the session" do
      get :confirm
      expect(subject).to redirect_to root_path
    end
  end

  describe "POST 'cancel'" do
    it "redirects to root_path" do
      post :cancel, id: order.id
      expect(subject).to redirect_to root_path
    end
  end
end
