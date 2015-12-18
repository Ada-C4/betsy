Rails.application.routes.draw do

  root 'welcome#index'
  get "/users/:id/products" => "users#products", as: :user_products
  post '/users/:user_id/orders/:order_id/order_items/:id' => 'order_items#shipped', as: :shipped
  get "/users/:user_id/order_items" => 'order_items#index', as: :not_shipped_yet
  post 'orders/:id' => 'orders#cancel', as: :cancel_order

  resources :categories, except: [:new, :update]
  resources :users do
    resources :orders, only: [:index, :show] do
      resources :order_items, only: [:show]
    end
    resources :products, except: [:index, :destroy] do

      resources :reviews, except: [:new]
      member do
        post 'cart/' => 'carts#add', as: :add_to_cart
        patch 'cart/' => 'carts#update'
        delete 'cart/' => 'carts#destroy', as: :remove
        post '/' => 'products#retire', as: :retire
      end
    end
  end


  get 'cart/' => 'carts#index', as: :cart

  get 'products/' => 'products#index', as: :products
  get 'login/' => 'sessions#new', as: :login
  post 'login/' => 'sessions#create'
  delete 'logout/' => 'sessions#destroy', as: :logout
  get 'checkout/' => 'orders#new', as: :checkout_new
  post 'checkout/' => 'orders#create', as: :checkout_submit
  get 'confirmation/' => 'orders#confirm'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
