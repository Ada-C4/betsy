require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let (:product) { FactoryGirl.create(:product) }

  let (:bad_params) {
    { user_id: product.user.id,
      product: { price: "zzz" }
    }
  }

  let (:sample_category_1) {
    Category.create(name: "Pool toys")
  }

  let (:sample_category_2) {
    Category.create(name: "Fun in the sun")
  }

  let (:good_params) {
    { user_id: product.user.id, categories: [sample_category_1.id, sample_category_2.id], product: { name: "Loofah",  price: "600", stock: "2", photo_url: "hi.jpg" } }
  }

  describe "GET 'index'" do
    it "is successful" do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe "GET 'show'" do
    it "renders the show view" do
      get :show, {id: product.id, user_id: product.user.id}, user_id: product.user.id
      expect(subject).to render_template :show
    end
    # it "redirects to root if not correct user" do
    #   get :show, {id: product.id, user_id: product.user.id + 1 }, user_id: product.user.id
    #   expect(subject).to redirect_to root_path
    # end
    it "assigns a new review as @review" do
      get :show, {id: product.id, user_id: product.user.id}, user_id: product.user.id
      expect(assigns(:review)).to be_a_new(Review)
    end
  end

  describe "GET 'new'" do
    it "renders new view" do
      get :new, {user_id: product.user.id}, {user_id: product.user.id}
      expect(subject).to render_template :new
    end
  end

  describe "POST 'create'" do
    context "with valid create params" do
      it "redirects to users's products page" do
        post :create, good_params, user_id: product.user.id
        expect(subject).to redirect_to user_products_path(product.user.id)
      end
    end

    context "with invalid create params" do
      it "re-renders new template" do
        post :create, bad_params, user_id: product.user.id
        expect(subject).to render_template :new
      end
    end
  end

  describe "GET 'edit'" do
    it "renders edit view" do
      get :edit, { id: product.id, user_id: product.user.id }, user_id: product.user.id
      expect(subject).to render_template :edit
    end
  end

  describe "PATCH 'update'" do
    context "with valid update params" do
      it "redirects to users's products page" do
        patch :update, good_params.merge({id: product.id}), user_id: product.user.id
        expect(subject).to redirect_to user_products_path(product.user)
      end
    end

    context "with invalid update params" do
      it "renders edit template on error" do
        patch :update, bad_params.merge({id: product.id}), user_id: product.user.id
        expect(subject).to render_template :edit
      end
    end
  end
end
