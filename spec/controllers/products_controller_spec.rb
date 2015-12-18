require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  before :each do
    @product = Product.create(name: "magic thing", price: 15.0, merchant_id: 1, description: "somethingsomething", photo_url: "stringthing", inventory: 4, retire: false)
    @product2 = Product.create(name: "magic thing2", price: 15.0, merchant_id: 1, description: "somethingsomething", photo_url: "stringthing", inventory: 5, retire: true)
    @category1 = Category.create(name: "hello")
    @category2 = Category.create(name: "hello again")
  end

  let (:update_params) do
    {
      product:{
        name: "Screaming Mandrake", price: 15.0, description: "hello", inventory: 100
      },
      id: @product.id,
    }
  end

  let (:badupdate_params1) do
    {
      product: { name: "magic thing", price: nil },
    id: @product.id,
    categories: [ 1, 2 ],
  }
  end

  let (:badupdate_params2) do
    {
      product: { inventory: -1 },
      id: @product.id,
      categories: [ 1, 2 ]
    }
  end

  let (:bad_params1) do
    {
      product: { name: "magic thing" },
      categories: [ 1, 2 ]
    }
  end

  let (:bad_params2) do
    {
      product: { inventory: -1},
      categories: [ 1, 2 ]
    }
  end

  let (:good_params) do
    {
      product:{ name: "bowwow", price: 15.0, description: "hello", inventory: 100 },
      categories: [ 1, 2 ]
    }

  end

  describe "Merchant is logged out" do

    describe "GET #index" do
      it "responds successfully with an HTTP 200 status code" do
        get :index
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end
      it "gets the name of category and makes it the header" do
        pending "need to figure out pathing"
        get :index, category_id: 1
        expect(response.body).to include "hello"
      end

    end

    describe "GET #show" do
      it "responds successfully with an HTTP 200 status code" do
        get :show, id: @product.id
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
      it "renders the show template" do
        get :show, id: @product.id
        expect(subject).to render_template :show
      end
    end

    describe "GET #new" do
      it "is not successful and redirects" do
        get :new, merchant_id: 1
        expect(response).to have_http_status(302)
      end
      it "redirects to the log in page" do
        get :new, merchant_id: 1
        expect(subject).to redirect_to new_session_path
      end
    end

    describe "POST #create" do
      it "is not successful and redirects" do
        post :create, good_params
        expect(response).to have_http_status(302)
      end
      it "does not create a new product" do
        original_count = Product.all.count
        post :create, good_params
        expect(Product.all.count).to eq original_count
      end
      it "redirects to the log in page" do
        post :create, good_params
        expect(subject).to redirect_to new_session_path
      end
    end

    describe "GET #edit" do
      it "is not successful and redirects" do
        get :edit, merchant_id: @product.merchant_id, id: @product.id
        expect(response).to have_http_status(302)
      end
      it "redirects to the log in page" do
        get :edit, merchant_id: @product.merchant_id, id: @product.id
        expect(subject).to redirect_to new_session_path
      end
    end

    describe "PATCH #update" do
      it "is not successful and redirects" do
        patch :update, update_params
        expect(response).to have_http_status(302)
      end
      it "redirects to the log in page" do
        patch :update, update_params
        expect(subject).to redirect_to new_session_path
      end
      it "does not update the product" do
        patch :update, update_params
        expect(Product.find(@product.id).attributes).to eq @product.attributes
      end
    end

    describe "DELETE #destroy" do
      it "is not successful and redirects" do
        delete :destroy, id: @product.id
        expect(response).to have_http_status(302)
      end
      it "redirects to the log in page" do
        delete :destroy, id: @product.id
        expect(subject).to redirect_to new_session_path
      end
      it "does not delete the product" do
        delete :destroy, id: @product.id
        expect(Product.all).to include(@product)
      end
    end

    describe "GET #retire" do
      before :each do
        @request.env['HTTP_REFERER'] = "/products/:id"
      end
      it "goes back to the page it was on" do
        get :retire, id: @product.id
        expect(response).to redirect_to "/products/:id"
      end
      it "goes back to the page it was on" do
        get :retire, id: @product2.id
        expect(response).to redirect_to "/products/:id"
      end
    end

  end

  describe "Merchant is logged in" do
    before :each do
      @merchant = Merchant.create(user_name: "Ollie", email: "o@diagonalley.com", password: "p", password_confirmation: "p")
      session[:merchant_id] = @merchant.id
    end

    describe "GET #index" do
      it "responds successfully with an HTTP 200 status code" do
        get :index
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end
    end

    describe "GET #new" do
      it "responds successfully with an HTTP 200 status code" do
        get :new, merchant_id: @product.merchant_id
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
      it "renders the new template" do
        get :new, merchant_id: @product.merchant_id
        expect(subject).to render_template :new
      end
    end

    describe "GET #show" do
      it "responds successfully with an HTTP 200 status code" do
        get :show, id: @product.id
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
      it "renders the show template" do
        get :show, id: @product.id
        expect(subject).to render_template :show
      end
    end

    describe "POST #create" do
      it "redirect to product show page" do
        post :create, good_params
        expect(subject).to redirect_to product_path(assigns(:product))
      end
      it "creates a new product" do
        original_count = Product.all.count
        post :create, good_params
        expect(Product.all.count).to eq original_count + 1
      end

      it "renders new template on error" do
        post :create, bad_params1
        expect(subject).to render_template :new
      end

      it "renders new template on error" do
        post :create, bad_params2
        expect(subject).to render_template :new
      end
    end

    describe "GET #edit" do
      it "renders the edit view" do
        get :edit, merchant_id: @product.merchant_id, id: @product.id
        expect(subject).to render_template :edit
      end
      it "does not allow merchant to render edit page for another merchant's product" do
        another_product = Product.create(name: "not mine", price: 15.0, merchant_id: 2, description: "somethingsomething", photo_url: "stringthing", inventory: 4)
        get :edit, merchant_id: another_product.merchant_id, id: another_product.id
        expect(subject).to redirect_to product_path(another_product)
      end
    end

    describe "PATCH #update" do
      it "redirects to show page" do
        patch :update, update_params
        expect(subject).to redirect_to product_path(update_params[:id])
      end
      it "updates the product" do
        patch :update, update_params
        expect(Product.find(@product.id).attributes).not_to eq @product.attributes
      end
      it "does not allow merchant to edit another merchant's product" do
        another_product = Product.create(name: "not mine", price: 15.0, merchant_id: 2, description: "somethingsomething", photo_url: "stringthing", inventory: 4)
        update_another_merchant_params = {
          product:{
            name: "Screaming Mandrake", price: 15.0, merchant_id: 2, description: "hello", inventory: 100
          },
          id: another_product.id
        }
        patch :update, update_another_merchant_params
        expect(Product.find(another_product.id).attributes).to eq another_product.attributes
        expect(subject).to redirect_to product_path(another_product)
      end
      it "renders edit template on error" do
        patch :update, badupdate_params1
        expect(subject).to render_template :edit
      end
      it "renders edit template on error" do
        patch :update, badupdate_params2
        expect(subject).to render_template :edit
      end
    end

    describe "DELETE #destroy" do
      it "redirects to merchant show page" do
        delete :destroy, id: @product.id
        expect(subject).to redirect_to merchant_path(@merchant)
      end
      it "deletes the product" do
        delete :destroy, id: @product.id
        expect(Product.all).to_not include(@product)
      end
      it "does not allow merchant to delete another merchants product" do
        another_product = Product.create(name: "not mine", price: 15.0, merchant_id: 2, description: "somethingsomething", photo_url: "stringthing", inventory: 4)
        delete :destroy, id: another_product.id
        expect(Product.all).to include(another_product)
        expect(subject).to redirect_to product_path(another_product)
      end
    end
  end
end
