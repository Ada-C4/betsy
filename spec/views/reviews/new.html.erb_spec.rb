# require 'rails_helper'
#
# RSpec.describe "reviews/new", type: :view do
#   before(:each) do
#     assign(:review, Review.new(
#       :rating => 1,
#       :product_id => 1,
#       :description => "MyString"
#     ))
#   end
#
#   it "renders new review form" do
#     render
#
#     assert_select "form[action=?][method=?]", reviews_path, "post" do
#
#       assert_select "input#review_rating[name=?]", "review[rating]"
#
#       assert_select "input#review_product_id[name=?]", "review[product_id]"
#
#       assert_select "input#review_description[name=?]", "review[description]"
#     end
#   end
# end
