require 'rails_helper'

RSpec.describe Order, type: :model do

  describe ".validate" do
    it "Order can have no order items when pending" do
      expect(Order.new(status: "pending")).to be_valid
    end
    it "Order must have order items when paid, complete or cancelled" do
      expect(Order.new(status: "paid")).to_not be_valid
      expect(Order.new(status: "complete")).to_not be_valid
      expect(Order.new(status: "cancelled")).to_not be_valid
    end
  end
end
