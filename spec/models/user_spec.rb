require 'rails_helper'

RSpec.describe User, type: :model do
  let (:review) { FactoryGirl.create(:review) }
  let (:user) { review.product.user}
  it { is_expected.to have_secure_password }

  describe ".validates" do
    it { is_expected.to validate_presence_of(:email) }

    it "must have a unique email" do
      expect(User.new(name: "Nemo", username: "Nemo1", email: user.email, password: "123", password_confirmation: "123")).to_not be_valid
    end

    it "downcases email before checking validity" do
      expect(User.new(name: "Nemo", username: "Nemo1", email: user.email.upcase, password: "123", password_confirmation: "123")).to_not be_valid
    end

    it "must have a valid email" do
      expect(User.new(email: 'nemo@foo,com', name: "Bob", username: "bobi", password: "333", password_confirmation: "333")).to_not be_valid
      expect(User.new(email: 'nemo_at_foo.org', name: "Bob", username: "bobi", password: "333", password_confirmation: "333")).to_not be_valid
      expect(User.new(email: 'nemo.user@foo.', name: "Bob", username: "bobi", password: "333", password_confirmation: "333")).to_not be_valid
      expect(User.new(email: 'nemo@bar_baz.com', name: "Bob", username: "bobi", password: "333", password_confirmation: "333")).to_not be_valid
      expect(User.new(email: 'nemo@bar+baz.com', name: "Bob", username: "bobi", password: "333", password_confirmation: "333")).to_not be_valid
      expect(User.new(email: ' ', name: "Bob", username: "bobi", password: "333", password_confirmation: "333")).to_not be_valid
      expect(User.new(email: 'nemo@nemo.com', name: "Bob", username: "bobi", password: "333", password_confirmation: "333")).to be_valid
    end

  end

  describe ".average_rating" do
    it "returns 0 if there are no products" do
      expect(User.new().average_rating).to eq 0
    end
    it "returns 0 if there are no ratings" do
      new_user = FactoryGirl.create(:user, username: "new_user", email: "new_user@example.com")
      new_user.products << Product.create(name:"new product", price: 500, stock: 10)
      expect(new_user.average_rating).to eq 0
    end
    it "returns the correct average for products" do
      user.products.first.reviews << Review.create(product_id: user.products.first.id, rating: 3)
      expect(user.average_rating).to eq 3.5
    end

  end


end
