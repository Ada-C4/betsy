require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe ".validates" do
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:product_id) }

    it "requires a quantity in correct range" do
      expect(FactoryGirl.build(:orderitem)).to be_valid
      expect(OrderItem.new(product_id: 1, order_id: 1, quantity: 0)).to be_invalid
      expect(OrderItem.new(product_id: 1, order_id: 1, quantity: -1)).to be_invalid
    end
  end
end
