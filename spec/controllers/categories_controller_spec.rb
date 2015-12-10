require 'rails_helper'
require 'support/app_controller'


RSpec.describe CategoriesController, type: :controller do

  let(:create_params) do {
    name: 'Category'
  }
    
  end

  let (:show_item) {Category.create(create_params)}

    it "renders the show view" do
      get :show, id: show_item.id
      expect(response.status).to eq 200
    end

  it_behaves_like "a quartzy controller"
end
