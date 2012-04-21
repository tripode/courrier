Project::Application.routes.draw do
  
  
  #match 'users/:id' => 'registrations#delete_user', :as => :delete_user, :via => :delete

  resources :cargo_manifests do
     collection do
       post 'get_transport_guides'
    end
  end

  devise_for :users,:controllers => { :registrations => "registrations" } do
    delete "/users/delete/:id" => 'registrations#delete_user', :as => :delete_user
    get    "/users/profiles/:id" => 'registrations#change_profile', :as => :change_profile
  end
  
  get 'main_page/index'

  resources :routing_sheet_details

  resources :transport_guide_details

  resources :transport_guides

  resources :products

  resources :receivers

  resources :routing_sheets

  resources :retire_note_details


  resources :retire_notes

  resources :foreign_companies

  resources :rounting_sheets

  resources :employees

  resources :customers
  
  resources :customer_companies
  
  devise_for :users

  resources :products do
     collection do
       post 'getProductType'
       post 'getReceiver'
       post 'getCustomer'
       post 'getItem'
    end
  end
  
 
  

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
   root :to => 'main_page#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
