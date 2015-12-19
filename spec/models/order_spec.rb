require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "model validations" do
    let(:bad_order){Order.new}

    required_fields = [:name, :bill_zip, :cc_exp, :cc_num, :city, :email, :sec_code, :state, :street, :zip]

    required_fields.each do |field|
      it "must have #{field}" do
          expect(bad_order).to_not be_valid
          expect(bad_order.errors.keys).to include(field)
      end
    end
  end

  describe "#total_cost" do
    it "returns total cost of an order" do
      product = Product.new({name: "Sea Anemone", price: 5.00, photo_url: "http://www.cabrillomarineaquarium.org/_photos/species-green-sea-anemone.jpg", description: "Is it fluffy, or slimy?", quantity: 5, merchant_id: 1})
      order = Order.new({purchase_time: Time.now, name: "Ricky", email: "ricky@awesome.com", street: "Ada Street", city: "Seattle", state: "WA", zip: 98112, cc_num: "1234", cc_exp: Time.now.to_date, sec_code: 123, bill_zip: 98112, status: "Paid"})
      order_item = OrderItem.new({quantity: 1, order_id: 1, product_id: 1})
      product.orders << order
      order.order_items << order_item
      order_item.product = product
      expect(order.total_cost).to eq 5.00
    end
  end
end
