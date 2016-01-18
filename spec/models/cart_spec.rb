require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:product) { FactoryGirl.create(:product) }
  let(:cart) {{ product.id => 3 }}
  let(:empty_cart) {{ }}

  describe ".total" do
    it "calculates the correct subtotal" do
      expected_total = product.price * cart[product.id]
      expect(Cart.total(cart)).to eq expected_total
    end
    it "calculates the correct subtotal for an empty cart" do
      expect(Cart.total(empty_cart)).to eq 0
    end
  end
end
