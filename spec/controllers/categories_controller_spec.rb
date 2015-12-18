require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  before :each do
    @category = Category.create(name: 'catprod')
    request.env["HTTP_REFERER"] = "where_i_came_from"
    @current_robot = Robot.create(username: "robo", email: "robo@email.com", password: "BestPosswordOfAll")
    session[:robot_id] = @current_robot.id
  end

  describe "POST 'create'" do
    let(:good_params) do
      {
        category: {
          name: 'catprod',
        }
      }
    end

    let(:create_params) do
      {
        category: {
          name: 'different',
        }
      }
    end

    let(:bad_params) do
      {
        category: {
          name: ''
        }
      }
    end
    it "renders the new page on failure" do
      post :create, bad_params
      expect(response).to render_template :new
    end

    it "redirects to the referring page on success" do
      post :create, create_params
      expect(response).to redirect_to robot_path(@current_robot)
      expect(Category.count).to eq 2
    end
  end

  describe "GET 'new'" do
    it "renders the new view" do
      get :new, robot_id: @current_robot
      expect(response).to render_template("new")
    end
  end
end
