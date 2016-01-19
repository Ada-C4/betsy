require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let (:params) do
    {
      user: {
        first_name: "Ms",
        last_name: "Snuffleupagus",
        email: "test@test.com",
        password: "password"
      }
    }
  end

  let(:user) do
       User.create(params[:user])
  end

  describe "POST 'create'" do

    let (:session_data) do
      {
        session_data: {
          email:"test@test.com",
          password: "password"
        }
      }
    end

    let (:session_data_bad_pass) do
      {
        session_data: {
          email:"test@test.com",
          password:"dog"
        }
      }
    end

    let (:session_data_bad_email) do
      {
        session_data: {
          email:"newtest@test.com",
          password:"password"
        }
      }
    end

    it "doesn't allow access to users who are logged in" do
      user
      session[:user_id] = 1
      post :create, session_data
      expect(subject).to redirect_to products_path
      expect(flash[:error]).to include "You are already logged in"
    end

    it "allows users to log in with a correct email and password" do
      user
      session[:user_id] = nil
      post :create, session_data
      expect(subject).to redirect_to root_path
    end

    it "doesn't allow users to log in with an incorrect password" do
      user
      session[:user_id] = nil
      post :create, session_data_bad_pass
      expect(subject).to render_template :new
    end

    it "doesn't allow users to log in with an unregistered email" do
      user
      session[:user_id] = nil
      post :create, session_data_bad_email
      expect(subject).to render_template :new
    end

  end



  describe "DELETE 'destroy'" do
    it "doesn't allow access to users who not logged in" do
      session[:user_id] = nil
      delete :destroy
      expect(subject).to redirect_to new_session_path
    end

    it "logs out the user who is logged in" do
      user
      session[:user_id] = 1
      delete :destroy
      expect(subject).to redirect_to root_path
    end
  end
end
