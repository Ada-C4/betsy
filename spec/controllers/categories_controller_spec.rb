require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:category) { FactoryGirl.create(:category) }
  let(:valid_attributes) {{ name: "New category" }}
  let(:invalid_attributes) {{ name: "" }}

  describe "GET 'index'" do
    it "is successful" do
      get :index
      expect(response.status).to eq 200
    end
    it "assigns all categories as @categories" do
      get :index
      expect(assigns(:categories)).to eq([category])
    end
  end

  describe "GET #show" do
    it "assigns the requested category as @category" do
      get :show, :id => category.id
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "GET #edit" do
    it "assigns the requested category as @category" do
      get :edit, :id => category.id
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, {:category => valid_attributes}, user_id: 1
        }.to change(Category, :count).by(1)
      end

      it "assigns a newly created category as @category" do
        post :create, {:category => valid_attributes}, user_id: 1
        expect(assigns(:category)).to be_a(Category)
        expect(assigns(:category)).to be_persisted
      end

      it "redirects to the category index" do
        post :create, {:category => valid_attributes}, user_id: 1
        expect(response).to redirect_to(categories_path)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved category as @category" do
        post :create, {:category => invalid_attributes}, user_id: 1
        expect(assigns(:category)).to be_a_new(Category)
      end

      it "re-renders the 'index' template" do
        post :create, {:category => invalid_attributes}, user_id: 1
        expect(response).to render_template("index")
      end
    end
  end
end
