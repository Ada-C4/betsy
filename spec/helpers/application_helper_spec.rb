require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the OrderItemsHelper. For example:
#
# describe OrderItemsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe ".readable_date" do
    it "turns a DateTime object into a readable_date" do
      date = DateTime.new(1991,3,21)
      expect(readable_date(date)).to eq "March 21, 1991 - 12:00"
    end
  end

  describe ".cents_to_dollars" do
    it "converts cents to dollars" do
      price = 2000
      expect(cents_to_dollars(price)).to eq "$20.00"
    end
  end

  describe ".cc_expiration" do
    it "converts the credit card expiration to a readable format" do
      expiration_date = DateTime.new(2018,03,01)
      expect(cc_expiration(expiration_date)).to eq "Mar 2018"
    end
  end

end
