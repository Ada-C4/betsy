Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root 'welcome#index'

  # carts routes
  resources :carts, :only => [:index, :show]
  post "/carts/:product_id/remove" => 'carts#remove_quantity', as: :remove_quantity
  post "/carts/:product_id/add" => 'carts#add_quantity', as: :add_quantity
  delete "/carts/" => 'carts#destroy'

  # sessions routes
  resources :sessions, :only => [:new, :create]
  delete "/logout", to: 'sessions#destroy', as: :logout

  # categories routes
  resources :categories, :only => [:show, :create, :new]

  # products routes (see more below under resources :merchants)
  resources :products, :only => :show
  post "/products/:id/add_review" => 'products#create_review', as: :create_review
  get "/products/" => 'products#all_products', as: :products
  patch "products/:id/retire" => "products#retire", as: :retire_product
  patch "products/:id/activate" => "products#activate", as: :activate_product

  # orders routes
  get 'orders/checkout' => 'orders#checkout', as: :checkout
  post 'orders/checkout' => 'orders#create'
  get 'orders/:id/confirm' => 'orders#confirm', as: :order_confirm
  get "merchants/:id/orders/show/:status" => 'orders#status', as: :status_orders

  # merchants routes
  get "merchants/home" => "merchants#home", as: :merchant_home

  resources :merchants, :except => :destroy do
    resources :products, :except => :show
    resources :orders, :except => [:destroy, :new, :create]
    resources :order_items, :only => [:edit, :update]
  end

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
