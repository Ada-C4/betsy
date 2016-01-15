class WelcomeController < ApplicationController
    before_action :navbar_categories, only: [:index]
    
  def index
    x = rand(1..User.all.length)
    until User.find(x).products.length >= 2
      x = rand(1..User.all.length)
    end
    y = rand(1..User.all.length)
    until y != x && User.find(y).products.length >= 2
      y = rand(1..User.all.length)
    end
    @top_users = [User.find(x), User.find(y)]
    m = rand(1..Category.all.length)
    until Category.find(m).products.length >= 2
      m = rand(1..Category.all.length)
    end
    n = rand(1..Category.all.length)
    until n != m && Category.find(n).products.length >= 2
      n = rand(1..Category.all.length)
    end
    @top_categories = [Category.find(m), Category.find(n)]
  end
end
