class WelcomeController < ApplicationController
  def index
    @categories = Category.all
    @merchants = Merchant.all
  end
end
