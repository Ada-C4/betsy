require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:product) { FactoryGirl.create(:product) }
  let(:cart) {{ 1 => 6, 2 => 1, 5 => 3 }}

  describe "GET 'index'" do
    it "is successful" do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe "PATCH 'update'" do
    context "there is enough stock to update cart" do
      let(:valid_params) {{
        product: { new_quantity: '4' },
        user_id: product.user.id,
        id: product.id
      }}
      it "redirects to cart path" do
        patch :update, valid_params, cart: { product.id => valid_params[:product][:new_quantity] }
        expect(subject).to redirect_to cart_path
      end
    end
    context "there is not enough stock to update cart" do
      let(:invalid_params) {{
        product: { new_quantity: '1000' },
        user_id: product.user.id,
        id: product.id
      }}
      it "displays flash error" do
        patch :update, invalid_params, cart: { product.id => invalid_params[:product][:new_quantity] }
        expect(flash[:error]).to_not be_nil
      end
      it "redirects to cart path" do
        patch :update, invalid_params, cart: { product.id => invalid_params[:product][:new_quantity] }
        expect(subject).to redirect_to cart_path
      end
    end
  end

  describe "POST 'add'" do
    let(:new_params) do
      { product: { add_quantity: 1},
        user_id: product.user.id,
        id: product.id }
      end
    let(:add_again_params) do
      { product: { add_quantity: 4},
        user_id: product.user.id,
        id: product.id }
    end
    let(:invalid_params) do
      { product: { add_quantity: 1000},
        user_id: product.user.id,
        id: product.id }
    end

    context "adding product for the first time" do
      it "updates cart" do
        post :add, new_params
        expect(session[:cart]).to_not be_nil
        expect(session[:cart][product.id.to_s]).to eq 1
      end
      it "redirects to cart_path" do
        post :add, new_params
        expect(subject).to redirect_to cart_path
      end
    end
    context "adding to product already in cart" do
      it "adds quantity to cart" do
        post :add, new_params
        post :add, add_again_params
        expect(session[:cart][product.id.to_s]).to eq 5
      end
      it "redirects to cart_path" do
        post :add, new_params
        post :add, add_again_params
        expect(subject).to redirect_to cart_path
      end
    end
    context "not enough product in stock" do
      it "creates a flash error" do
        post :add, invalid_params
        expect(flash[:error]).to_not be_nil
      end
      it "redirects to product page" do
        post :add, invalid_params
        expect(subject).to redirect_to user_product_path(product.user_id, product.id)
      end
    end
  end

  describe "DELETE destroy" do
    # it "removes the product from the cart" do
    #   product_id = 1
    #   delete :destroy, {user_id: 1, id: product_id}, cart: cart
    #   expect(session[:cart][product_id]).to be_nil
    # end

    it "redirects to cart_path" do
      delete :destroy, {user_id: 1, id: 1}, cart: cart
      expect(subject).to redirect_to cart_path
    end
  end
end
