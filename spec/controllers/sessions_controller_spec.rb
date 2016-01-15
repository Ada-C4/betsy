require 'rails_helper'

# RSpec.describe SessionsController, type: :controller do
#   before :each do
#     session[:user_id] = user.id
#   end
#
#   describe "POST 'create'" do
#       let (:session_data) do
#         {
#           email: "info@diamonds.com",
#           username: "diamonds",
#           password: "password"
#         }
#       end
#
#       it "creates an authenticated session" do
#         user = User.find_by_username(session_data[:username])
#         post :create, :session_data => session_data
#         expect(response).to redirect_to user_path(user.id)
#       end
#     end
#
#   describe "DELETE #destroy" do
#
#     before(:each) do
#       @user = User.create :user
#       sign_in @user, store: false
#       delete :destroy, id: @user.auth_token
#     end
#     it { should respond_with 204 }
#   end
# end
