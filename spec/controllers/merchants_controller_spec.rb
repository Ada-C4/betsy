require 'rails_helper'

RSpec.describe MerchantsController, type: :controller do

    describe "logged out functions" do

      describe "GET 'new'" do
        it "responds successfully with a 200 status code" do
          get :new
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end
      end

      describe "POST 'create'" do
        let (:params) do
          {
            merchant:{
              user_name: "Ginny", email: "ginny@hogwarts.com", password: "p", password_confirmation: "p"
            },
          }
        end

          let (:bad_params) do
            {
              merchant:{
                email: "ginny@hogwarts.com", password: "p", password_confirmation: "p"
              }
            }
        end

        it "redirects to merchant show page when merchant is created" do
          post :create, params
          expect(subject).to redirect_to merchant_path(session[:merchant_id])
        end

        it "renders a new page when user already exists or if info doesn't pass validations" do
          post :create, bad_params
          expect(subject).to render_template :new
        end
      end
    end

    describe "Logged in functions" do
      let (:merchant) do
        Merchant.create(user_name: "Hailey", email: "spiderlover222@hogwarts.com", password: "123", password_confirmation: "123")
      end
      let(:new_merchant_params) do
        {
          merchant:{
            user_name: "Hello", email: "h@hogwarts.com", password: "p", password_confirmation: "p"
          },
        }
      end

    before (:each) do
      session[:merchant_id] = merchant.id
    end

    describe "GET #new" do
      it "is not successful and redirects" do
        get :new
        expect(response).to have_http_status(302)
      end
      it "redirects to the merchant show page" do
        get :new
        expect(subject).to redirect_to merchant_path(merchant)
      end

      describe "POST #create" do
        it "redirects to merchant show page" do
          post :create, new_merchant_params
          expect(subject).to redirect_to merchant_path(merchant)
        end
        it "does not create a new merchant" do
          original_count = Merchant.all.count
          post :create, new_merchant_params
          expect(Merchant.all.count).to eq original_count
        end
      end
      describe "GET #show" do
        it "responds successfully with an HTTP 200 status code" do
          get :show, id: merchant.id
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end

        it "renders the show template" do
          get :show, id: merchant.id
          expect(subject).to render_template :show
        end
      end
    end
  end
end
