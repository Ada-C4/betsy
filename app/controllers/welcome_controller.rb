class WelcomeController < ApplicationController
  def index
    @products = Product.where(active: true).limit(12)
  end
end
