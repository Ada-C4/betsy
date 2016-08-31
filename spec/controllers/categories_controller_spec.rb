require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  let (:good_params) do
    {
      category:{ name: "Cool Stuff" }
    }
  end

    let (:bad_params) do
      {
        category:{ name: nil }
      }
  end

  describe "Merchant is logged out" do
    describe "GET #new" do
      it "is not successful and redirects" do
        get :new
        expect(response).to have_http_status(302)
      end
      it "redirects to the log in page" do
        get :new
        expect(subject).to redirect_to new_session_path
      end
    end

    describe "POST #create" do
      it "is not successful and redirects" do
        post :create, good_params
        expect(response).to have_http_status(302)
      end
      it "does not create a new category" do
        original_count = Category.all.count
        post :create, good_params
        expect(Category.all.count).to eq original_count
      end
      it "redirects to the log in page" do
        post :create, good_params
        expect(subject).to redirect_to new_session_path
      end
    end
  end


  describe "Merchant is logged in" do
    before :each do
      @merchant = Merchant.create(user_name: "Harry", email: "h@potter.com", password: "p", password_confirmation: "p")
      session[:merchant_id] = @merchant.id
    end

    describe "GET #new" do
      it "responds successfully with an HTTP 200 status code" do
        get :new
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
      it "renders the new template" do
        get :new
        expect(subject).to render_template :new
      end
    end

    describe "POST #create" do
      it "redirect to merchant show page" do
        post :create, good_params
        expect(subject).to redirect_to merchant_path(@merchant)
      end
      it "creates a new category" do
        original_count = Category.all.count
        post :create, good_params
        expect(Category.all.count).to eq original_count + 1
      end

      it "renders new template on error" do
        post :create, bad_params
        expect(subject).to render_template :new
      end
    end
  end
end
