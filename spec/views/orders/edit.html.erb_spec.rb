# require 'rails_helper'
#
# RSpec.describe "orders/edit", type: :view do
#   before(:each) do
#     @order = assign(:order, Order.create!(
#       :email => "MyString",
#       :street => "MyString",
#       :city => "MyString",
#       :state => "MyString",
#       :zip => "MyString",
#       :cc_num => "MyString",
#       :cc_cvv => 1,
#       :cc_name => "MyString"
#     ))
#   end
#
#   it "renders the edit order form" do
#     render
#
#     assert_select "form[action=?][method=?]", order_path(@order), "post" do
#
#       assert_select "input#order_email[name=?]", "order[email]"
#
#       assert_select "input#order_street[name=?]", "order[street]"
#
#       assert_select "input#order_city[name=?]", "order[city]"
#
#       assert_select "input#order_state[name=?]", "order[state]"
#
#       assert_select "input#order_zip[name=?]", "order[zip]"
#
#       assert_select "input#order_cc_num[name=?]", "order[cc_num]"
#
#       assert_select "input#order_cc_cvv[name=?]", "order[cc_cvv]"
#
#       assert_select "input#order_cc_name[name=?]", "order[cc_name]"
#     end
#   end
# end
