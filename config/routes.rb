Rails.application.routes.draw do
  get 'welcome/index'
 root 'welcome#index'
  get 'locations/new'

  get 'locations/index'

  get 'locations/edit'
    get 'transactions/all/edit' => 'transactions#edit_all', :as => :edit_all
    put 'transactions/all' => 'transactions#update_all', :as => :update_all
    get 'transactions/batch/new' => 'transactions#new_batch', :as => :new_batch
    put 'transactions/batch' => 'transactions#create_batch', :as => :create_batch  
    resources :locations
    resources :prerolls
    resources :items
    resources :transactions
    get 'reports/index', :as => :reports
    get 'reports/summary' => 'reports#summary', :as => :summary_report
    get 'reports/by_sub' => 'reports#by_sub', :as => :by_sub_report
 

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
