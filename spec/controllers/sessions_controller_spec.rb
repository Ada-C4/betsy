require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  before(:each) do
    @merchant = Merchant.create(username: "Seabay", email: "info@seabay.com", password: "password", password_confirmation: "password")
  end

  describe "POST 'create'" do
    let (:session_data) do
      {
        email: "info@seabay.com",
        username: "Seabay",
        password: "password"
      }

    end

    it "creates an authenticated session" do
      merchant = Merchant.find_by_username(session_data[:username])
      merchant.authenticate(session_data[:password])
      post :create, :session_data => session_data
      expect(subject).to redirect_to merchant_home_path(merchant.id)
    end

    it "flashes an error with incorrect data" do
      merchant = Merchant.find_by_username(session_data[:username])
      merchant.authenticate("badpass")
      post :create, :session_data => {email: "info@seabay.com", password: "badpass"}
      expect(subject).to render_template :new
    end
  end

  describe "DELETE #destroy" do
    it "allows merchant to log out" do
      session[:user_id] = @merchant.id
      delete :destroy
      expect(session[:user_id]).to eq(nil)
    end
  end

end
