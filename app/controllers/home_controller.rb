class HomeController < ApplicationController

  def index
    @categories = Category.all
    @featured_products = Product.all.shuffle.last(4)


    @merchants = Merchant.all
  end
end
