require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  before(:each) do
    @product = Product.create(name: "hi", price: 100, stock: 2, robot_id: 1)
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  let(:review_params) do
    {
      rating: 3, 
      comment: "comment",
      product_id: 1
    }
  end

  describe "POST 'create'" do 
    it "creates view" do
      Review.create(review_params)
      expect(Review.count).to eq(1)
      # 4 reviews created in product as well
    end

    it "redirects back to product page" do 
      post :create, { product_id: @product.id.to_s, review: review_params }
      expect(response).to redirect_to "where_i_came_from"
    end
  end
end