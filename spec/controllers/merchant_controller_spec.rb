require 'rails_helper'

RSpec.describe MerchantsController, type: :controller do
  let(:good_params) do
    { merchant: {
        username: "kdefliese",
        email: "kdefliese@gmail.com",
        password: "cats",
        password_confirmation: "cats"}
    }
  end

  let(:bad_params) do
    { merchant: {
        username: nil,
        email: nil,
        password: nil,
        password_confirmation: nil}
    }
  end

  describe "GET 'new'" do
    it "is successful" do
      get :new
      expect(response.status).to eq 200
      expect(subject).to render_template :new
    end
  end

  describe "POST 'create'" do
    it "successful create redirects to log in page" do
      post :create, good_params
      expect(Merchant.all.length).to eq 1
      expect(response.status).to eq 302
      expect(subject).to redirect_to merchant_home_path(1)
    end
    it "unsuccessful create renders new page" do
      post :create, bad_params
      expect(Merchant.all.length).to eq 0
      expect(response.status).to eq 200
      expect(subject).to render_template :new
    end
  end

  describe "GET 'home'" do
    it "gets show page for correct merchant if logged in" do
      test_merchant = Merchant.create(good_params[:merchant])
      session[:user_id] = test_merchant.id
      get :home, id: test_merchant.id
      expect(subject).to render_template :home
    end
    it "does not show merchant home page if not logged in" do
      session[:user_id] = nil
      get :home, id: 1
      expect(subject).to redirect_to new_session_path
    end
  end

  describe "GET 'show page'" do
    it "is successful" do
      test_merchant = Merchant.create(good_params[:merchant])
      get :show, id: test_merchant.id
      expect(response.status).to eq 200
      expect(subject).to render_template :show
    end
  end
end
