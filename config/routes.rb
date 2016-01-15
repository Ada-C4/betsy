Rails.application.routes.draw do
  root to: 'welcome#index'

  get '/sessions/new' => 'sessions#new', as: :login
  get '/users/new' => 'users#new', as: :signup

  get "/logout" => "sessions#destroy", as: :logout

  get '/cart' => 'orders#cart', as: :cart

  delete 'cart/clear_cart' => 'orders#clear_cart', as: :clear_cart

  delete '/cart/orderitems/:id' => 'orderitems#destroy', as: :orderitems_delete

  patch '/cart/pay' => 'orders#pay', as: :pay

  get '/cart/checkout'  => 'orders#checkout', as: :checkout

  get '/orders/:id/confirm' => 'orders#confirm', as: :order_confirm

  patch '/orderitems/:id/ship' => 'orderitems#ship', as: :ship

  patch 'orderitems/:id/update' => 'orderitems#update', as: :orderitems_update

  patch 'orders/:id/finalize' => 'orders#finalize', as: :order_finalize

  patch 'orders/:id/cancel_as_guest' => 'orders#cancel_as_guest', as: :order_cancel_as_guest

  post '/products/:id/buy' => 'products#buy', as: :buy

  get '/users/:id/dash' => 'users#dash', as: :user_dash

  get 'users/:id/order_dash' => 'users#order_dash', as: :user_order_dash

  get '/users/:id/products' => 'users#product_dash', as: :user_products_dash

  patch '/products/:id/retire' => 'products#retire', as: :retire

  resources :sessions, :only => [:new, :create]
  resources :users
  resources :products do
    post "/review", to: "products#review"
  end
  resources :orders
  resources :categories
end
