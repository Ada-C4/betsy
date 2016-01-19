require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  let(:user) do
    User.create(first_name: "Someone",
                last_name: "Else",
                email: "7@7.co",
                password: "pass",
                password_confirmation: "pass")
  end

  describe "POST 'create'" do
    let(:order_item_params) do
      {
        order_item: {
          quantity: 12,
        },
        product_id: 6,
      }
    end

    before :suite do
      cookies.signed[:order] = nil
    end

    it "creates a new order instance when one does not already exist" do
      all_orders = Order.all.to_a
      post :create, order_item_params
      expect(all_orders).not_to include(Order.all.last)
    end

    before :suite do
      ord = Order.create(status:"pending")
      cookies.signed[:order] = ord.id
    end

    it "does not create a new order instance when one already exists" do
      last_order = Order.last
      post :create, order_item_params
      expect(Order.last).to_not eq last_order
    end

    it "redirects to the cart path when successful" do
      post :create, order_item_params
      expect(subject).to redirect_to cart_path
    end

  end

  describe "GET 'cart'" do
    it "renders the cart view" do
      get :cart
      expect(subject).to render_template :cart, { :id => 1 }
    end
  end

  describe "PATCH 'update'" do

    before :each do
      @product = Product.create(name:"Test A", description: "A Description", price: 100, inventory_total: 1, retired: false, image_url: "http://cdn.cutestpaw.com/wp-content/uploads/2012/08/s-fuzzy.jpg", user_id: 1, :categories => Category.where(:name => ['people']))
      @order_item = OrderItem.create(quantity: 1, order_id: 200, product_id: @product.id)
    end

    let(:order_item_params) do
      {
        order_item: {
          quantity: 0,
        },
        product_id: @product.id,
        id: @order_item.id,
      }
    end

    it "renders the cart" do
      patch :update, order_item_params
      expect(subject).to redirect_to cart_path
    end

    it "destroys the order item if the quantity is 0" do
      how_many_order_items_before = OrderItem.all.to_a.length
      patch :update, order_item_params
      expect(OrderItem.all.length).to_not eq(how_many_order_items_before)
    end

    let(:order_item_params_two) do
      {
        order_item: {
          quantity: 2,
        },
        product_id: @product.id,
        id: @order_item.id,
      }
    end

    describe "if the quantity is not 0" do

      it "does not destory the order item if the quantity is not 0" do
        how_many_order_items_before = OrderItem.all.to_a.length
        patch :update, order_item_params_two
        expect(OrderItem.all.length).to eq(how_many_order_items_before)
      end

      it "increases the order item's quantity" do
        patch :update, order_item_params_two
        expect(OrderItem.find(@order_item.id).quantity).to eq(2)
      end

    end


  end

  describe "DELETE 'destroy'" do

    before :each do
      @product = Product.create(name:"Test A", description: "A Description", price: 100, inventory_total: 1, retired: false, image_url: "http://cdn.cutestpaw.com/wp-content/uploads/2012/08/s-fuzzy.jpg", user_id: 1, :categories => Category.where(:name => ['people']))
      @order_item = OrderItem.create(quantity: 1, order_id: 200, product_id: @product.id)
    end

    let(:order_item_params) do
      {
        order_item: {
          quantity: 0,
        },
        product_id: @product.id,
        id: @order_item.id,
      }
    end

    it "renders the cart" do
      delete :destroy, order_item_params
      expect(subject).to redirect_to cart_path
    end

    it "destroys the order item from the database" do
      num_of_order_items_before = OrderItem.all.to_a.length
      delete :destroy, order_item_params
      expect(OrderItem.all.to_a.length).to eq(num_of_order_items_before - 1)
    end
  end

end
