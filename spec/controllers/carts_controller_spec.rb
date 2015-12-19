require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:product) do
    Product.create(name: "Stuff", price: 500, quantity: 5)
  end

  describe "POST 'create'" do
    it "gets a success response when creating a new cart" do
      expect(response.status).to eq 200
    end
  end

  describe "DELETE 'destroy'" do
    it "deletes session's cart info and redirects to the home page" do
      delete :destroy, id: 1
      expect(session[:cart]).to eq nil
      expect(response.status).to eq 302
      expect(subject).to redirect_to root_path
    end
  end

  describe "GET 'index'" do
    it "shows the cart index template, if nothing in cart" do
      get :index
      expect(response.status).to eq 200
      expect(subject).to render_template :index
    end

    it "shows the cart index template with something in cart" do
      post :add_quantity, product_id: product.id
      get :index
      expect(response.status).to eq 200
      expect(subject).to render_template :index
    end
  end

  describe "POST 'add_quantity'" do
    it "successfully adds item to cart" do
      post :add_quantity, product_id: product.id
      post :add_quantity, product_id: product.id
      expect(session[:cart][product.id.to_s]).to eq 2
      expect(subject).to redirect_to carts_path
    end

    it "redirects to the cart page if product was not yet in cart" do
      post :add_quantity, product_id: product.id
      expect(session[:cart][product.id.to_s]).to eq 1
      expect(response.status).to eq 302
      expect(subject).to redirect_to carts_path
    end

    it "gives flash error if you try to add an item that is out of stock" do
      unavailable_product = Product.create(name: "Stuff", price: 500, quantity: 0)
      post :add_quantity, product_id: unavailable_product.id
      expect(session[:cart][product.id.to_s]).to eq nil
      expect(flash[:error]).to eq "You cannot add more items than are in stock."
    end

    it "gives flash error if you try to add more of an item than is in stock" do
      one_of_product = Product.create(name: "Stuff", price: 500, quantity: 1)
      post :add_quantity, product_id: one_of_product.id
      post :add_quantity, product_id: one_of_product.id
      expect(session[:cart][one_of_product.id.to_s]).to eq 1
      expect(flash[:error]).to eq "You cannot add more items than are in stock."
    end
  end

  describe "POST 'remove_quantity'" do
    it "gives flash error if you try to remove an item that doesn't exist in cart" do
      post :remove_quantity, product_id: product.id
      expect(session[:cart][product.id.to_s]).to eq nil
      expect(flash[:error]).to eq "This item has already been removed from your cart."
    end

    it "redirects to the cart page" do
      post :add_quantity, product_id: product.id
      post :remove_quantity, product_id: product.id
      expect(response.status).to eq 302
      expect(subject).to redirect_to carts_path
    end
  end

end
