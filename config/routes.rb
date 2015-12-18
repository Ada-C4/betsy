Rails.application.routes.draw do
  root 'home#index'

  # Robot jobs
  get 'signup' => 'robots#new', :as => 'signup'
  resources :robots do
    get 'fulfillment' => 'orders#fulfill', :as => 'fulfillment'
  end

  # Product jobs
  get '/products/robots/:id', to: 'products#robot', as: 'by_robot'
  get '/products/categories/:category_name', to: 'products#category', as: 'by_category'
  patch 'products/retire/:id' => 'products#retire', as: "retire"

  resources :products do
    resources :reviews, only: [:new, :create]
  end

  #sessions controller
  resources :sessions, only: [:new, :create, :destroy]
  get 'login' => 'sessions#new', :as => 'login'
  get 'logout' => 'sessions#destroy', :as => 'logout'

  # Categories controller
  resources :categories, only: [:new, :create]

  # Orders controller
  get '/orders/checkout' => 'orders#checkout', as: 'checkout'
  patch '/orders/confirm' => 'orders#confirm', as: 'confirm'
  patch '/orders/cancel' => 'orders#cancel', as: 'cancel'
  patch '/orders/finalize' => 'orders#finalize', as: 'finalize'
  get '/robots/:id/orders/:id/info' => 'orders#info', as: 'info'
  resources :orders

  # Orderitems controller
  patch 'orderitems/:id/ship' => 'orderitems#ship', as: :ship
  patch '/products/:id/add' => 'orderitems#add_to_cart'
  post '/products/:id/add' => 'orderitems#add_to_cart'
  patch 'products/:id/more' => 'orderitems#increase_quantity', as: :more
  patch 'products/:id/less' => 'orderitems#decrease_quantity', as: :less
  delete 'products/:id/remove' => 'orderitems#remove', as: :remove
end
