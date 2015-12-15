require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:order_hash) do
  {
    status: "pending",
    cc_name: "John Carlisle",
    email_address: "jcarl@gmail.com",
    mailing_address: "653 Gorge Way",
    cc_number: 5110538084994719,
    cc_exp: "06/18",
    cc_cvv: "674",
    zip: 19583
  }
  end

  let(:order) do
    Order.create!(order_hash)
  end

  describe "GET 'show'" do
    it "renders the show view" do
      get :show, id: order.id
      expect(subject).to render_template :show
    end
  end

  describe "GET 'cart'" do

  end

  # clear_cart
  # checkout
  # confirm
  # cancel_as_user
  # cancel_as_guest
  # finalize
  # ship
  # pay
  # edit
  # update
  # destroy

  it_behaves_like "a quartzy controller"
end
