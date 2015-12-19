require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:good_params) do
    {category: {
      name:"category"}
    }
  end
  
  let(:bad_params) do
    {category: {
      name: nil
      }}
  end

  let(:merchant) do
    Merchant.create(username: "Apple", email: "email345@email.com", password: "password", password_confirmation: "password")
  end

  let(:session_data) do
    {
      username: "Apple",
      password: "password"
    }
  end

  describe "GET 'new'" do
    it "is successful" do
      merchant.authenticate(session_data)
      session[:user_id] = merchant.id

      get :new
      expect(response.status).to eq 200
      expect(subject).to render_template :new
    end
  end

  describe "POST 'create'" do
    it "successful create redirects to category show page" do
      expect(Category.all.length).to eq 0
      post :create, good_params
      expect(response.status).to eq 302
      expect(Category.all.length).to eq 1
      new_category = Category.last
      expect(subject).to redirect_to category_path(new_category.id)
    end
    it "unsuccessful create renders new page" do
      post :create, bad_params
      expect(Category.all.length).to eq 0
      expect(response.status).to eq 200
      expect(subject).to render_template :new
    end
  end

  describe "GET 'show'" do
    it "successful show renders show page" do
      test_category = Category.create(good_params[:category])
      expect(Category.all.length).to eq 1
      get :show, id: test_category.id
      expect(response.status).to eq 200
      expect(subject).to render_template :show
    end
  end
end
