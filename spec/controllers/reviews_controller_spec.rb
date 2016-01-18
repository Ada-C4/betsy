require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:review) { FactoryGirl.create(:review) }
  describe "GET 'index'" do
    it "is successful" do
      get :index, product_id: review.product_id, user_id: review.product.user_id
      expect(response.status).to eq 200
    end
    it "assigns all reviews as @reviews" do
      get :index, product_id: review.product_id, user_id: review.product.user_id
      expect(assigns(:reviews)).to eq([review])
    end
  end

  # describe "GET 'edit'" do
  #   it "renders edit page" do
  #     get :edit, product_id: review.product_id, user_id: review.product.user_id, id: review.id
  #     expect(subject).to render_template :edit
  #   end
  #
  #   it "assigns the requested review as @review" do
  #     get :edit, product_id: review.product_id, user_id: review.product.user_id, id: review.id
  #     expect(assigns(:review)).to eq(review)
  #   end
  #
  # end

  describe "GET 'show'" do
    it "renders show page" do
      get :show, product_id: review.product_id, user_id: review.product.user_id, id: review.id
      expect(subject).to render_template :show, product_id: review.product_id, user_id: review.product.user_id, id: review.id
    end

    it "assigns the requested review as @review" do
      get :show, product_id: review.product_id, user_id: review.product.user_id, id: review.id
      expect(assigns(:review)).to eq(review)
    end

  end

  describe "POST 'create'" do
    let(:product) { FactoryGirl.create(:product) }
    let(:valid_create_attributes) {
      {
        user_id: product.user_id,
        product_id: product.id,
        review: { rating: 4, description: "Great!" }}
    }
    let(:invalid_create_attributes) {
      {
        user_id: product.user_id,
        product_id: product.id,
        review: { description: "The worst"}
      }
    }
    context "with valid params" do
      it "redirects to product show page" do
        post :create, valid_create_attributes
        new_review = Review.last
        expect(subject).to redirect_to user_product_path(new_review.product.user_id, new_review.product_id)
      end
      it "creates a new Review" do
        expect {
          post :create, valid_create_attributes
        }.to change(Review, :count).by(1)
      end

      it "assigns a newly created review as @review" do
        post :create, valid_create_attributes
        expect(assigns(:review)).to be_a(Review)
        expect(assigns(:review)).to be_persisted
      end
    end
    context "with invalid params" do
      it "assigns a newly created but unsaved review as @review" do
        post :create, invalid_create_attributes
        expect(assigns(:review)).to be_a_new(Review)
      end
      it "re-renders the product show template" do
        post :create, invalid_create_attributes
        expect(subject).to redirect_to user_product_path(product.user_id, product.id)
      end
    end
  end

  describe "PATCH 'update'" do
    let(:valid_update_attributes) {
      {
        id: review.id,
        user_id: review.product.user_id,
        product_id: review.product.id,
        review: { rating: 4, description: "Great!" }}
    }
    let(:invalid_update_attributes) {
      {
        id: review.id,
        user_id: review.product.user_id,
        product_id: review.product.id,
        review: { rating: -1 }
      }
    }
    context "with valid params" do
      # it "updates the requested review" do
      #   patch :update, valid_update_attributes
      #   review.reload
      #   expect(assigns(:review)).to
      # end
      it "assigns the requested review as @review" do
        patch :update, valid_update_attributes
        expect(assigns(:review)).to eq(review)
      end
      it "redirects to user_product_reviews" do
        patch :update, valid_update_attributes
        expect(subject).to redirect_to user_product_reviews_path(review.product.user_id, review.product_id)
      end
    end
    context "with invalid params" do
      it "assigns the review as @review" do
        patch :update, invalid_update_attributes
        expect(assigns(:review)).to eq(review)
      end
      it "re-renders edit template" do
        patch :update, invalid_update_attributes
        expect(subject).to render_template (:edit)
      end
    end
  end

  describe "DELETE 'destroy'" do
    # it "destroys the requested review" do
    #   expect {
    #     delete :destroy, id: review.id, user_id: review.product.user_id, product_id: review.product_id
    #   }.to change(Review, :count).by(-1)
    # end

    it "redirects to user_product_reviews" do
      delete :destroy, id: review.id, user_id: review.product.user_id, product_id: review.product_id
      expect(subject).to redirect_to user_product_reviews_path(review.product.user_id, review.product_id)
    end
  end
end
