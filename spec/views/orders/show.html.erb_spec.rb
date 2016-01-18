# require 'rails_helper'
#
# RSpec.describe "orders/show", type: :view do
#   before(:each) do
#     @order = assign(:order, Order.create!(
#       :email => "Email",
#       :street => "Street",
#       :city => "City",
#       :state => "State",
#       :zip => "Zip",
#       :cc_num => "Cc Num",
#       :cc_cvv => 1,
#       :cc_name => "Cc Name"
#     ))
#   end
#
#   it "renders attributes in <p>" do
#     render
#     expect(rendered).to match(/Email/)
#     expect(rendered).to match(/Street/)
#     expect(rendered).to match(/City/)
#     expect(rendered).to match(/State/)
#     expect(rendered).to match(/Zip/)
#     expect(rendered).to match(/Cc Num/)
#     expect(rendered).to match(/1/)
#     expect(rendered).to match(/Cc Name/)
#   end
# end
