require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  describe "POST 'create'" do
    let (:params) do
      {
        review: {
          rating: 5, description: "lovely"
        },
        product_id: 1
      }
    end

    let (:bad_review_params) do
      {
        review: {
          description: "horrible"
        },
        product_id: 1
      }
    end

    it "renders new page if review was not saved" do
      post :create, bad_review_params
      expect(subject).to render_template :new
    end

    it "goes to the product show page if review was successful" do
      post :create, params
      expect(subject).to redirect_to product_path(params[:product_id])
    end

  end

  describe  "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new, product_id: 2
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

end
