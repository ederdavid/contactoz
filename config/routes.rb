ActionController::Routing::Routes.draw do |map|
  map.resources :registers
  map.resources :services
  map.resources :registers


  map.connect 'users.:format', :controller => 'users', :action => 'apiSearch'

  map.connect 'companies.:format', :controller => 'companies', :action => 'apiSearch'

  map.connect 'contacts.:format', :controller => 'contacts', :action => 'apiSearch'

  map.connect 'products.:format', :controller => 'products', :action => 'apiSearch'

  map.connect 'services.:format', :controller => 'services', :action => 'apiSearch'

  map.resources :topics

  map.resources :posts

  map.resources :application

  map.resources :display_companies

  map.resources :displays

  map.resources :products

  map.connect 'services/:action', :controller => 'services', :action => /[a-z_]+/i

  
  map.connect 'users/:action', :controller => 'users', :action => /[a-z_]+/i

  map.connect 'contacts/:action', :controller => 'contacts', :action => /[a-z_]+/i

  map.connect 'contact_saveds/:action', :controller => 'contact_saveds', :action => /[a-z_]+/i

  map.connect 'companies/:action', :controller => 'companies', :action => /[a-z_]+/i
  
  map.resources :password_resets, :only => [ :new, :create, :edit, :update ]

  map.activate '/activate/:activation_code', :controller => 'activations', :action => 'create'

  map.resources :plans


  map.resources :services

  map.resources :products
   map.resources :feeds
  map.resources :contact_saveds

  map.resources :actions

  map.resources :activities

  map.resources :companies

  map.resources :contacts

  map.resources :user_sessions

  map.resources :users, :collection => {:borrar => :delete}

  map.resources :homes, :collection => {:cart => :put}

  map.connect '/cart', :controller => 'contacts'
  map.connect '/add_post', :controller => 'users', :action => 'add_post'

  map.connect '/export_to_csv', :controller => 'companies', :action => 'export_to_csv'


  map.register "registrar", :controller => "registers", :action => "index"

  map.display_company "display_companies/:id", :controller => "display_companies", :action => "show"  
  map.display_contact "display_contacts/:id", :controller => "displays", :action => "show" 
  map.login "login", :controller => "user_sessions", :action => "create"
  map.register "registrar", :controller => "registers", :action => "index"

  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"
  map.connect '', :controller => "Companies"
  map.root :controller => 'Companies'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.

  map.connect ':controller/:action.:format'  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
