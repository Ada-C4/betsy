require 'rails_helper'

RSpec.describe Merchant, type: :model do

  describe ".validates" do
    it "must have a user name" do
      expect(Merchant.new(user_name: nil, email: "x@y.com", password: "a", password_confirmation:"a")).to_not be_valid
    end
    it "user name must be unique" do
      Merchant.create(user_name: "hello", email: "x@y.com", password: "a", password_confirmation:"a")
      expect(Merchant.new(user_name: "hello", email: "x@y.com", password: "a", password_confirmation:"a")).to_not be_valid
    end
    it "user name can have 25 characters" do
      expect(Merchant.new(user_name: "a" * 25, email: "x@y.com", password: "a", password_confirmation:"a")).to be_valid
    end
    it "user name cannot have 26 characters" do
      expect(Merchant.new(user_name: "a" * 26, email: "x@y.com", password: "a", password_confirmation:"a")).to_not be_valid
    end
    it "must have an email address" do
      expect(Merchant.new(user_name: "a", email: nil, password: "a", password_confirmation:"a")).to_not be_valid
    end
    it "email address name must be unique" do
      Merchant.create(user_name: "hello", email: "x@y.com", password: "a", password_confirmation:"a")
      expect(Merchant.new(user_name: "cat", email: "x@y.com", password: "a", password_confirmation:"a")).to_not be_valid
    end
    it "email can have 50 characters" do
      expect(Merchant.new(user_name: "a", email: ("a" * 44 + "@y.com"), password: "a", password_confirmation:"a")).to be_valid
    end
    it "email name cannot have 51 characters" do
      expect(Merchant.new(user_name: "a", email: ("a" * 46 + "@y.com"), password: "a", password_confirmation:"a")).to_not be_valid
    end
    it "password confirmation must match password" do
      expect(Merchant.new(user_name: "a", email: "a@y.com", password: "a", password_confirmation:"abb")).to_not be_valid
    end
  end
end
