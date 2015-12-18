# require 'rails_helper'
#
# RSpec.describe "reviews/edit", type: :view do
#   before(:each) do
#     @review = assign(:review, Review.create!(
#       :rating => 1,
#       :product_id => 1,
#       :description => "MyString"
#     ))
#   end
#
#   it "renders the edit review form" do
#     render
#
#     assert_select "form[action=?][method=?]", review_path(@review), "post" do
#
#       assert_select "input#review_rating[name=?]", "review[rating]"
#
#       assert_select "input#review_product_id[name=?]", "review[product_id]"
#
#       assert_select "input#review_description[name=?]", "review[description]"
#     end
#   end
# end
