require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET 'index'" do 
    it "returns the index page with success" do 
      get :index
      expect(response).to be_success
      expect(response.status).to eq 200
      expect(response).to have_http_status 200
    end
  end
end
