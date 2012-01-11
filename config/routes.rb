Depot::Application.routes.draw do
  get "sessions/new"

  get "users/new"

  get "store/index"

  get "users/upgrade"

  get "sandbox/show"

  get "bids/add_bids"
  get "products/update"
  get "products/ship"

  match '/update', :to => 'products#update'
  resources :products
  resources :users

  resources :sessions, :only => [:new, :create, :destroy]
  resources :bids

  match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'

  match '/signup',  :to => 'users#new'
  match '/additem', :to => 'products#new'
  match '/viewitems', :to => 'products#index'
  match '/upgradeaccount', :to => 'users#upgrade'
  match '/profile', :to => 'users#show'
  match "/products/:id" => redirect("/products/%{id}")
  match '/home', :to => 'sessions#new'
  match '/showitem', :to => 'products#show'
  match '/allItems', :to => 'store#allProducts'
  match '/allusers', :to => 'users#index'
  match '/allproducts', :to => 'products#index'
  match '/reports', :to => 'users#reports'
  match '/payment', :to => 'products#payment'



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'store#index' ,:as => 'store'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
