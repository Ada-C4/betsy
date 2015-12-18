# require 'rails_helper'
#
# RSpec.describe "orders/index", type: :view do
#   before(:each) do
#     assign(:orders, [
#       Order.create!(
#         :email => "Email",
#         :street => "Street",
#         :city => "City",
#         :state => "State",
#         :zip => "Zip",
#         :cc_num => "Cc Num",
#         :cc_cvv => 1,
#         :cc_name => "Cc Name"
#       ),
#       Order.create!(
#         :email => "Email",
#         :street => "Street",
#         :city => "City",
#         :state => "State",
#         :zip => "Zip",
#         :cc_num => "Cc Num",
#         :cc_cvv => 1,
#         :cc_name => "Cc Name"
#       )
#     ])
#   end
#
#   it "renders a list of orders" do
#     render
#     assert_select "tr>td", :text => "Email".to_s, :count => 2
#     assert_select "tr>td", :text => "Street".to_s, :count => 2
#     assert_select "tr>td", :text => "City".to_s, :count => 2
#     assert_select "tr>td", :text => "State".to_s, :count => 2
#     assert_select "tr>td", :text => "Zip".to_s, :count => 2
#     assert_select "tr>td", :text => "Cc Num".to_s, :count => 2
#     assert_select "tr>td", :text => 1.to_s, :count => 2
#     assert_select "tr>td", :text => "Cc Name".to_s, :count => 2
#   end
# end
