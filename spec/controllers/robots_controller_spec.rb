require 'rails_helper'

RSpec::Matchers.define :require_login do

  match do |actual|
    redirect_to Rails.application.routes.url_helpers.login_path
  end

  failure_message do |actual|
    "expected to require login to access the method"
  end

  description do
    "redirect to the login form"
  end

end

RSpec.describe RobotsController, type: :controller do

  describe "GET 'new'" do 
    it "gets new successfully" do 
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET 'show'" do
    Robot.create(email: "testy@test.com", username: "testytest", password_digest: "test")
    it "renders the show view for a robot" do
      get :show, id: 1
      expect(response.status).to eq 302
    end
  end

  describe 'require login' do 
    let(:robot) { create(:robot) }

    it "redirects to new session when non-robot tries to go to show" do
      current_robot = Robot.create(username: "test", email: "test@test.com", password: "test", password_confirmation: "test")
      get :show, id: current_robot.id
      expect(response).to require_login
    end
  end

  describe "POST 'create'" do 
    let(:good_params) do 
      {
        robot: {
          username: 'name_2',
          email: 'robot2@robot2.com',
          password: 'test',
          password_confirmation: 'test'
        }
      }
    end

    let(:bad_params) do 
      {
        robot: {
          username: 'name_2',
          password: 'test',
          password_confirmation: 'test'
        }
      }
    end

    it "creates robot" do 
      post :create, good_params 
      expect(Robot.count).to eq 2
    end

    it "redirects to login page" do 
      post :create, good_params
      expect(subject).to redirect_to new_session_path
    end

    it "renders new with bad params" do 
      post :create, bad_params
      expect(subject).to render_template(:new)
    end
  end
end
