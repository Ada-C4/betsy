require 'pry'

RSpec.describe OrderItem, type: :model do
  describe "model validations" do
      it "must have a quantity, order_id, and product_id" do
        test_orderitem = OrderItem.new()
        expect(test_orderitem).to_not be_valid
        expect(test_orderitem.errors.keys).to include :quantity
        expect(test_orderitem.errors.keys).to include :order_id
        expect(test_orderitem.errors.keys).to include :product_id
      end
      it "can't have a quantity that is an integer" do
        test_orderitem = OrderItem.new({ quantity: "hi" })
        expect(test_orderitem).to_not be_valid
        expect(test_orderitem.errors.keys).to include :quantity
      end
      it "can't have a quantity equal to 0" do
        test_orderitem = OrderItem.new({ quantity: 0 })
        expect(test_orderitem).to_not be_valid
        expect(test_orderitem.errors.keys).to include :quantity
      end
      it "can't have a quantity less than 0" do
        test_orderitem = OrderItem.new({ quantity: -1 })
        expect(test_orderitem).to_not be_valid
        expect(test_orderitem.errors.keys).to include :quantity
      end
      it "belongs to an order and product" do
        test_order = Order.create({purchase_time: Time.now, name: "Ricky", email: "ricky@awesome.com", street: "Ada Street", city: "Seattle", state: "WA", zip: 98112, cc_num: 1234, cc_exp: Time.now.to_date, sec_code: 123, bill_zip: 98112})
        test_produt = Product.create(  {name: "Sea Anemone", price: 500, photo_url: "http://www.cabrillomarineaquarium.org/_photos/species-green-sea-anemone.jpg", description: "Is it fluffy, or slimy?", quantity: 5, merchant_id: 1})
        test_orderitem = OrderItem.create({ quantity: 3, order_id: 1, product_id: 1 })
        expect(test_orderitem.order.id).to eq 1
        expect(test_orderitem.product.id).to eq 1
      end
    end
end
