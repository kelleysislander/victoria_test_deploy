Victoria::Application.routes.draw do


  match '/auth/:provider/callback' => 'authentications#create'
  # match '/auth/:provider/callback' => 'devise/sessions#create'
  
  # new_user_session GET    /users/sign_in(.:format)                {:action=>"new", :controller=>"devise/sessions"}
  #     user_session POST   /users/sign_in(.:format)                {:action=>"create", :controller=>"devise/sessions"}
      
  resources :authentications
  resources :deal_types
  resources :advertisers
  resources :advertiser_types
  resources :advertisement_types
  resources :advertisements
  resources :retailer_categories
  resources :retailers
  resources :deals
  resources :accounts
  # resources :maps, :only => [:index, :new, :create]
  resources :redemptions
  resources :traffic_data_types
  resources :traffic_ratings
  resources :traffic_conditions
  resources :traffic_cameras
  resources :traffic_condition_historicals
  resources :redemption_passphrases
  resources :device_redemptions, :only => [ :index, :show, :destroy ]
  resources :mobile_user_events, :only => [ :index, :show, :destroy ]

  # role-based menu layouts used here
  resources :admin, :only => [:index] # used the "admin" layout
  resources :traffic_conditions, :only => [:index] # uses the "traffic" layout

  resources :maps, :only => [:index, :new, :create] do
    collection do
      get 'zones'
    end
  end

  resources :api, :only => [:index] do
    collection do
      get   :redeem
      get   :deals_with_ads
      get   :traffic_alerts
      get   :traffic_alerts_with_ads
      # get   :auth_test
      # get   :remote_signin
      get   :get_auth_token
      # post  :auth_existing_user
      # post  :remote_signup
      # post  :auth_new_user
    end
  end
  
  # get "traffic_conditions/test_populate_div"
  # get "traffic_conditions/test_populate_div_2"

  # get "map/basic"

  devise_for :users, :controllers => {:registrations => "registrations"} 
  devise_scope :user do
    match '/auth/:provider/callback' => 'devise/sessions#create'
    get '/login' => 'devise/sessions#new'
    get '/logout' => 'devise/sessions#destroy'
  end
  resources :token_authentications, :only => [:create, :destroy]
  resources :user, :controller => "user"
  
  # resources :posts
  # resources :map, :only => [:basic, :points]
  

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "dashboard#index"
  
  # has to be last
  match '*a', :to => 'errors#routing'
  
end

=begin  
  # root :to => 'users#index'
  # root :to => "authentications#index"
  # root :to => "user#new"

  # destroy_user_session DELETE /users/sign_out(.:format)      {:action=>"destroy", :controller=>"devise/sessions"}
  
  # match 'users/sign_out' => 'devise/sessions#destroy', :as => :sign_out, :via => [:delete]
  # match 'login' => 'sessions#new', :as => :login
  # match 'forgot_password' => 'password_resets#new', :as => :forgot_password
  # match 'reset_password/:id', :to => 'password_resets#edit', :as => :reset_password
  
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


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
=end
