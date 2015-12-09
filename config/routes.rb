Rails.application.routes.draw do
  root 'home#index'

  post '/products/:id/add' => 'orderitems#add_to_cart'

  resources :products do
    resources :reviews
  end

  resources :categories, only: [:new, :create]

  resources :robots

  resources :orders
end
