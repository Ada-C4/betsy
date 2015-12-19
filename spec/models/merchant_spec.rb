require 'rails_helper'

RSpec.describe Merchant, type: :model do
  let(:empty_merchant) do
      Merchant.new()
  end
  let(:good_merchant) do
    Merchant.create({
      username: "merchant",
      email: "sdfs@sdf.com",
      password: "123",
      password_confirmation: "123"
    })
  end

  describe "model validations" do
      it "must have a username" do
        expect(empty_merchant).to_not be_valid
        expect(empty_merchant.errors.keys).to include :username
      end
      it "must have an email" do
        expect(empty_merchant).to_not be_valid
        expect(empty_merchant.errors.keys).to include :email
      end
      it "must have a unique username" do
        good_merchant
        non_unique_username = Merchant.new({ username: "merchant", email: "gdfs@sdf.com", password: "123", password_confirmation: "123" })
        expect(non_unique_username.save).to eq false
        expect(non_unique_username.errors.keys).to include :username
      end
      it "must have a unique email" do
        good_merchant
        non_unique_email = Merchant.new({ username: "merchant2", email: "sdfs@sdf.com", password: "123", password_confirmation: "123" })
        expect(non_unique_email.save).to eq false
        expect(non_unique_email.errors.keys).to include :email
      end
      it "must have a password confirmation that matches password" do
        passwords_not_matching = Merchant.new({ username: "merchant1", email: "sdfs@sdf.com", password: "123", password_confirmation: "321" })
        expect(passwords_not_matching.save).to eq false
        expect(passwords_not_matching.errors.keys).to include :password_confirmation
      end
    end
end
