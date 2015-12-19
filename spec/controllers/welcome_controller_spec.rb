require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe "GET 'home page'" do
    it "is successful" do
      get :index
      expect(response.status).to eq 200
      expect(subject).to render_template :index
    end
  end
end
