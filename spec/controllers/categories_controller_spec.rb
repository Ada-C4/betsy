require 'rails_helper'
require 'support/app_controller'


RSpec.describe CategoriesController, type: :controller do

  let(:create_params) do {
    name: 'Category'
  }

  end

  let (:show_item) {Category.create(create_params)}

    it "renders the show view" do
      get :show, id: show_item.id
      expect(response.status).to eq 200
    end

  describe "GET 'new'" do
    it "renders new view" do
      get :new
      expect(subject).to render_template :new if @current_user != nil
    end
  end

  describe "POST 'create'" do
    let(:user) do
      User.create(username: "Mister",
                  email_address: "stud@manly.com",
                  password: "pw",
                  password_confirmation: "pw")
    end

    let(:good_params) do
      {
        category: {
          name: "Rock"
        }
      }
    end

    let(:bad_params) do
      {
        category: {
          name: nil
        }
      }
    end

    before :each do
      session[:user_id] = user.id
    end

    it "redirects to products index page when good params are passed" do
      post :create, good_params.merge(id: 1)
      expect(subject).to redirect_to user_products_dash_path(user.id)
    end

    it "renders the edit template when bad params are passed" do
      post :create, bad_params
      expect(subject).to render_template :new
    end
  end

  it_behaves_like "a quartzy controller"
end
