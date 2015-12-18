require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  describe "GET 'index'" do
    it "is successful" do
      get :index
      expect(response.status).to eq 200
    end
    it "assigns all users as @users" do
      get :index, id: user.id
      expect(assigns(:users)).to eq([user])
    end
  end

  describe "GET 'new'" do
    it "render new view" do
      get :new
      expect(subject).to render_template :new
    end
    it "assigns a new user as @user" do
      get :new, id: user.id
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "GET 'edit'" do
    it "renders edit view" do
      get :edit, {id: user.id}, user_id: user.id
      expect(subject).to render_template :edit
    end
    it "assigns the requested user as @user" do
      get :edit, {id: user.id}, user_id: user.id
      expect(assigns(:user)).to eq(user)
    end

  end

  describe "GET 'show'" do
    it "renders the show view" do
      get :show, {id: user.id}, user_id: user.id
      expect(subject).to render_template :show
    end
    it "assigns the requested user as @user" do
      get :show, {id: user.id}, user_id: user.id
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "POST 'create'" do
    let(:good_params) do
       {
        user: {
          username: "Nemo1",
          email: "nemo@gmail.com",
          password: "123",
          password_confirmation: "123"
        }
      }
    end

    let(:bad_params) do
      {
       user: {
         username: "",
         email: "nemo@gmail.com",
         password: "1223",
         password_confirmation: "123"
       }
      }
    end
    context "valid create params" do
      it "redirect to index page" do
        post :create, good_params
        expect(subject).to redirect_to users_path
      end
      it "creates a new User" do
        expect {
          post :create, good_params
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created review as @review" do
        post :create, good_params
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end
    end
    context "invalid create params" do
      it "assigns a newly created but unsaved user as @user" do
        post :create, bad_params
        expect(assigns(:user)).to be_a_new(User)
      end
      it "render new template on error" do
        post :create, bad_params
        expect(subject).to render_template :new
      end
    end
  end

  describe "PATCH 'update'" do
    let(:good_params) do
      { id: user.id,
        user: { email: "new_email@example.com"}}
    end

    let(:bad_params) do
      { id: user.id,
        user: { email: "" }}
    end

    context "with valid update params" do
      it "assigns the requested user as @user" do
        patch :update, good_params, user_id: user.id
        expect(assigns(:user)).to eq(user)
      end
      it "redirects to index page" do
        patch :update, good_params, user_id: user.id
        expect(subject).to redirect_to users_path
      end
    end

    context "with invalid update params" do
      it "assigns the user as @user" do
        patch :update, bad_params, user_id: user.id
        expect(assigns(:user)).to eq(user)
      end
      it "re-renders edit template" do
        patch :update, bad_params, user_id: user.id
        expect(subject).to render_template "edit"
      end
    end
  end
end
