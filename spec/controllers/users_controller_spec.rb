require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let (:params) do
    {
      user: {
        first_name: "Ms",
        last_name: "Snuffleupagus",
        email: "6@6.com",
        password: "pass"
      }
    }
  end

  let(:user) do
       User.create(params[:user])
  end

  let(:user_2) do
      User.create(first_name: "Test",
                  last_name: "Test",
                  email: "test@test.com",
                  password: "dog")
  end

  describe "GET 'new'" do
    it "renders the new view" do
      get :new
      expect(subject).to render_template :new
    end
  end

  describe "POST 'create'" do
    let (:params) do
      {
        user: {
          first_name: "Mister",
          last_name: "Snuffleupagus",
          email: "6@6.com",
          password: "pass"
        }
      }
    end

    let (:bad_params) do
      {
        user: {
          first_name: "Oscar",
          last_name: "The Grouch",
          email: nil,
          password: "pass"
        }
      }
    end

    it "creates a user with good params" do
      last_user = User.last
      post :create, params
      expect(User.last).to_not eq last_user
    end

    it "redirects to root path when a user is successfully created" do
      post :create, params
      expect(subject).to redirect_to root_path
    end

    it "does not create a user with bad params" do
      last_user  = User.last
      post :create, bad_params
      expect(User.last).to eq last_user
    end

    it "renders the create user page when bad params are used to try to create a user" do
      post :create, bad_params
      expect(subject).to render_template :new
    end
  end

  describe "GET 'show'" do
    describe "user logged in to correct user account" do
       before(:each) do
         session[:user_id] = 1
       end

       it "renders the show user page" do
         user
         user = User.find(1)
         get :show, id:user.id
         expect(response.status).to eq 200
       end
    end

    describe "user logged in to incorrect user account" do
      before(:each) do
        user
        user_2
        session[:user_id] = 2
      end

      it "redirects to the users show page" do
        user = User.find(1)
        get :show, id:user.id
        expect(subject).to redirect_to user_path(2)
      end
    end

    describe "user not logged in" do
      it "renders the login screen " do
        user
        user = User.find(1)
        get :show, id:user.id
        expect(response).to redirect_to new_session_path
      end
    end
  end

  describe "new_category" do

    let (:category_params) do
      {
        category: {
          name: "Test"
        }
      }
    end

    let (:bad_category_params) do
      {
        category: {
          name: nil
        }
      }
    end

    before(:each) do
      user
      session[:user_id] = 1
    end

    it "lets a signed in user create a new category" do
      post :new_category, category_params.merge(user_id: session[:user_id])
      expect(subject).to redirect_to user_path(session[:user_id])
      expect(session[:message]).to include "You have created a new category"
    end

    it "does not let a signed in user create a category without a name" do
      post :new_category, bad_category_params.merge(user_id: session[:user_id])
      expect(subject).to redirect_to user_path(session[:user_id])
      expect(flash[:error]).to eq "Categories must have a name!"

    end
  end
end
