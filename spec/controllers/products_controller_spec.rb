require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  before :each do
    @product = Product.create(name: 'Test', price: 1, robot_id: 1, stock: 1)
    @category = Category.create(name: 'Catprodlol')
    @product.categories << Category.find(1)
    @current_robot = Robot.create(username: "robo", email: "robo@email.com", password: "BestPosswordOfAll")
    session[:robot_id] = @current_robot.id

  end

  describe "GET 'index'" do
    it "is successful" do
      get :index
      expect(response.status).to eq 200
      expect(subject).to render_template :index
    end
  end

  describe "GET 'show'" do
    it "renders the show view for a product" do
      get :show, id: @product.id
      expect(response.status).to eq 200
      expect(subject).to render_template :show
    end
  end

  describe  "GET 'category'" do
    it "renders the show view for products of a single category" do
      get :category, category_name: @category.name
      expect(response.status).to eq 200
      expect(subject).to render_template :category
    end
  end

  describe "GET 'new'" do
    it "renders the new view" do
      get :new, robot_id: @current_robot
      expect(response).to render_template("new")
    end
  end

  describe "POST 'create'" do
    let(:good_params) do
      {
        product: {
          name: 'CatProd',
          price: 1,
          stock: 1,
          robot_id: 5,
        }
      }
    end

    let(:bad_params) do
      {
        product: {
          name: 'CatProd',
        }
      }
    end

    it "redirects to the product show page on success" do
      post :create, good_params
      expect(subject).to redirect_to product_path(1)
    end

    it "renders the new form if unsuccessful" do
      post :create, bad_params
      expect(subject).to render_template 'new'
    end
  end

  describe "GET 'edit'" do
    it "renders the edit form" do
      get :edit, id: @product.id
      expect(response.status).to eq 200
      expect(subject).to render_template 'edit'
    end
  end

  describe "PATCH 'update'" do
    let(:change_params) do
      {
        product: {
          name: 'Catprod',
          price: 1,
          stock: 1,
          robot_id: 2,
        }
      }
    end

    let(:bad_change_params) do
      {
        product: {
          name: '',
          price: 1,
          stock: 1,
          robot_id: 2,
        }
      }
    end

    it "updates a product" do
      patch :update, { id: @product.id }.merge(change_params)
      @product.reload
      expect(Product.find(1).name).to eq "Catprod"
    end

    it "redirects to robot page if successful" do
      patch :update, { id: @product.id }.merge(change_params)
      @product.reload
      expect(response).to redirect_to by_robot_path(@product.robot_id)
    end

    it "renders edit page if unsuccessful" do
      patch :update, { id: @product.id }.merge(bad_change_params)
      @product.reload
      expect(response).to render_template 'edit'
    end
  end
end
