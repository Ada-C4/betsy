require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET 'new'" do
    it 'renders the new page' do
      get :new
      expect(response.status).to eq 200
    end
  end

  describe "POST 'create'" do
    let(:user) { FactoryGirl.create(:user) }
    let(:valid_login_attributes) {
      { session_data: {
          username: user.username,
          password: user.password
          }}
    }
    let(:invalid_login_attributes) {
      { session_data: {
          username: user.username,
          password: "thisisthewrongpassword"
          }}
    }
    context "with valid login params" do
      it "redirects to homepage" do
        post :create, valid_login_attributes
        expect(subject).to redirect_to root_path
      end
      it "saves user id to session" do
        post :create, valid_login_attributes
        expect(session[:user_id]).to eq user.id
      end
    end

    context "with invalid login params" do
      it "re-renders the new template" do
        post :create, invalid_login_attributes
        expect(subject).to render_template :new
      end
      it "does not save the user id to session" do
        post :create, invalid_login_attributes
        expect(session[:user_id]).to be_nil
      end
    end
  end

  describe "DELETE 'destroy'" do
    let(:user) { FactoryGirl.create(:user) }
    let(:valid_login_attributes) {
      { session_data: {
          username: user.username,
          password: user.password
          }}
    }
    it "deletes user id from session" do
      post :create, valid_login_attributes
      delete :destroy
      expect(session[:user_id]).to be_nil
    end
  end

end
