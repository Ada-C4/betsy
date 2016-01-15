require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:good_hash) do {
    user: {
    username: "Burp",
    email_address: "thing@thing.com",
    password: "this",
    password_confirmation: "this"
    }}
  end

  let(:user) {User.create(good_hash)}

  # describe 'GET dash' do
  #   it "shows the user dash page" do
  #     get :dash, id: user.id
  #     expect(subject).to render_template :dash
  #   end
  # end
  describe "POST 'create'" do
    it "creates a new user" do
        post :create, good_hash
        expect(User.count).to eq(1)
    end

    it "success message upon create" do
      expect(response.status).to eq 200
    end
  end
end
