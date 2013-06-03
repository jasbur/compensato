RailsCompensato::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
    match 'main/system_shutdown' => 'main#system_shutdown'
    match 'file_ops/file_scan' => 'file_ops#file_scan'
    match 'file_ops/selected_files_log' => 'file_ops#selected_files_log'
    match 'file_ops/file_copy_progress' => 'file_ops#file_copy_progress'
    match 'file_ops/migrate_user_data' => 'file_ops#migrate_user_data'
    match 'file_ops/kill_copy' => 'file_ops#kill_copy'
    match 'file_ops/launch_iehv' => 'file_ops#launch_iehv'
    match 'file_ops/open_file_browser' => 'file_ops#open_file_browser'
    match 'file_ops/clean_temp_files' => 'file_ops#clean_temp_files'
    match 'file_ops/all_files_modified_on_date' => 'file_ops#all_files_modified_on_date'
    match 'file_ops/folder_browser' => 'file_ops#folder_browser'
    match 'downloads/fetch_downloads' => 'downloads#fetch_downloads'
    match 'diagnostics/ping_test' => 'diagnostics#ping_test'
    match 'diagnostics/stop_hardware_test' => 'diagnostics#stop_hardware_test'
    match 'diagnostics/check_system_temps' => 'diagnostics#check_system_temps'

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
    resources :file_ops
    resources :disk_ops
    resources :downloads
    resources :diagnostics

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
   root :to => 'main#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
