Rails.application.routes.draw do

  get "/cart" => "order_items#cart"
  get "/checkout" => "orders#checkout"
  get "/confirmation" => "orders#confirmation"

  root 'products#index'

  resources :products, :only => [:show, :index, :review] do
    post "/review", to: "products#review"
    resources :order_items, :only => [:create, :update, :destroy]
    #resources :order_items
  end

  #resources :orders, only: [:show, :update]
  resources :orders, only: [:update]

  resources :users, :except => [:destroy, :update, :edit, :index] do
    post "/categories/new", to: "users#new_category"
    resources :orders, :only => [:index, :show, :update] do
      post "/ship", to: "orders#ship"
    end
    resources :products, :except => [:destroy] do
      post "/retire", to: "products#retire"
    end
  end

  resources :sessions, :only => [:new, :create]
  delete "/logout", to: "sessions#destroy", as: :logout

end
