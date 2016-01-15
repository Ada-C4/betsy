require 'rails_helper'
require 'support/app_controller'

RSpec.describe ProductsController, type: :controller do
  describe "GET 'new'" do
    it "renders new view" do
      get :new
      expect(subject).to render_template :new
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
        product:{
          name: "necklace",
          price: 10,
          user_id: 2,
          stock: 3
        },
        categories: []
      }
    end

    let(:bad_params) do
      {
        product:{
          name: nil,
          price: nil
        },
        categories: []
      }
    end

    before :each do
      session[:user_id] = user.id
    end

    it "redirects to products index page when good params are passed" do
      post :create, good_params.merge(id: 1)
      expect(subject).to redirect_to product_path(user.id)
    end

    it "renders the edit template when bad params are passed" do
      post :create, bad_params
      expect(subject).to render_template :new
    end
  end

  describe "GET 'edit'" do
    let(:product) do
      Product.create(name: "necklace", price: 10, user_id: 2, stock: 3)
    end

    it "renders edit view" do
      get :edit, id: product.id
      expect(subject).to render_template :edit
    end
  end

  describe "GET 'show'" do
    let(:show_product) do
      Product.create(name: "necklace", price: 10, user_id: 2, stock: 3)
    end

    it "renders the show view" do
      get :show, id: show_product.id
      expect(subject).to render_template :show
    end
  end

  describe "PATCH 'update'" do
    before :each do
        request.env["HTTP_REFERER"] = "back"
    end

    let(:current_user) do
      User.create(username: "FancyPants",
                  email_address: "fancypants@fancypants.com",
                  password: "123",
                  password_confirmation: "123")
      end

    before :each do
      session[:user_id] = current_user.id
    end

    let(:product) do
      Product.create(name: "necklace",
                      price: 10,
                      user_id: current_user.id,
                      stock: 3)
    end

    let(:good_product_update) do
      {
        product: {
          name: "necklace",
          price: 25,
          user_id: current_user.id,
          stock: 3,
        },
        id: product.id
      }
    end

    it "updates a good product" do
      before_update = product.attributes
      params = good_product_update
      patch :update, params
      product.reload
      expect(product.attributes).to_not eq before_update
    end

    it "redirects to product#show page" do
      patch :update, good_product_update
      expect(subject).to redirect_to product_path(product.id)
    end

    let(:bad_product_update) do
      {
        product: {
          name: "",
          price: 10,
          user_id: current_user.id,
          stock: 3,
        },
        id: product.id
      }
    end

    it "doesn't update a product with bad params" do
      before_update = product.attributes
      params = bad_product_update
      patch :update, params
      product.reload
      expect(product.attributes).to eq before_update
    end

    it "renders edit view" do
      patch :update, bad_product_update
      expect(subject).to render_template :edit
    end
  end

  describe "POST 'review'" do
    let(:product) do
      Product.create(name: "necklace", price: 10, user_id: 2, stock: 3)
    end
    let(:review_params) do
    {
      id: product.id,
      review: {
        rating: 4,
        body: "so pretty!"
      }
    }
    end

    it "creates a new product review" do
      post :review, review_params.merge(product_id: product.id)
      last = Review.last
      expect(last.rating).to eq 4
    end
  end

  describe "PATCH 'retire'" do
    before :each do
        request.env["HTTP_REFERER"] = "back"
    end

    let(:product) do
      Product.create(name: "necklace",
                     price: 10,
                     user_id: 1,
                     stock: 3)
    end

    let(:update_product) do
      {
         id: product.id,
         product: {
           name: "necklace",
           price: 10,
           user_id: 1,
           stock: 3,
           retired: true
         }
       }
    end



    let(:current_user) do
      User.create(username: "FancyPants",
                  email_address: "fancypants@fancypants.com",
                  password: "123",
                  password_confirmation: "123")
    end

    ## should go in model_spec
    #  let(:current_user2) do
    #   User.create(username: "SoiledPants",
    #               email_address: "soiledpants@soiledpants.com",
    #               password: "123",
    #               password_confirmation: "123")
    # end

    before :each do
      session[:user_id] = current_user.id
    end

    ## should go in model_spec
    # it "sets the status of a product to retired" do
    #   before_retired = product.retired
    #   patch :retire, update_product
    #   product.reload
    #   expect(product.retired).to_not eq before_retired
    # end

    it "goes back to product show page on submit/update" do
      patch :retire, update_product
      expect(subject).to redirect_to "back"
    end

    ## should go in model_spec
    # it "doesn't let a user retire a product that they do not own" do
    #   update_product # trigger creation of product
    #   expect_any_instance_of(Product).not_to receive(:save)
    #   session[:user_id] = current_user2.id
    #   patch :retire, update_product
    #   expect(flash[:error]).to eq("You are not authorized to view this section")
    # end
  end

  describe "DELETE 'destroy'" do
    before :each do
        request.env["HTTP_REFERER"] = "back"
    end
    let(:product) do
      Product.create(name: "necklace", price: 10, user_id: 2, stock: 3)
    end

    it "redirects to products index page" do
      delete :destroy, id: product.id
      expect(subject).to redirect_to "back"
    end
  end

  it_behaves_like "a quartzy controller"
end
