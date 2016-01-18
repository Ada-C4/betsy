# require 'rails_helper'
#
# RSpec.describe "products/new", type: :view do
#   before(:each) do
#     assign(:product, Product.new(
#       :name => "MyString",
#       :price => 1,
#       :user_id => 1,
#       :photo_url => "MyString",
#       :stock => 1,
#       :description => "MyString",
#       :active => false
#     ))
#   end
#
#   it "renders new product form" do
#     render
#
#     assert_select "form[action=?][method=?]", products_path, "post" do
#
#       assert_select "input#product_name[name=?]", "product[name]"
#
#       assert_select "input#product_price[name=?]", "product[price]"
#
#       assert_select "input#product_user_id[name=?]", "product[user_id]"
#
#       assert_select "input#product_photo_url[name=?]", "product[photo_url]"
#
#       assert_select "input#product_stock[name=?]", "product[stock]"
#
#       assert_select "input#product_description[name=?]", "product[description]"
#
#       assert_select "input#product_active[name=?]", "product[active]"
#     end
#   end
# end
