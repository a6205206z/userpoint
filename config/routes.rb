Rails.application.routes.draw do
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
  get '/' => 'user#index'
  get 'user/index' => 'user#index'
  get 'user/signout' => 'user#sign_out'
  get 'user/recommend' => 'user#recommend'
  get 'user/user_info' => 'user#user_info'
  get 'user/user_info_mod' => 'user#user_info_mod'
  get 'user/user_account' => 'user#user_account'
  get 'user/user_address' => 'user#user_address'
  get 'user/use_order' => 'user#use_order'
  get 'user/login'  => 'user#login'
  get 'user/register' => 'user#register'
  get 'user/pointio' => 'user#user_point_io'
  get 'user/moneyio' => 'user#user_money_io'
  get 'user/inputcode' => 'user#user_input_code'
  get 'mall/index' => 'mall#index'
  get 'mall/product/:id' => 'mall#product_detail'
  get 'mall/makeorder' => 'mall#make_order'
  get 'mall/shipping' => 'mall#shipping'
  get 'user/orderlist' => 'user#order_list'
  get 'user/order/:id' => 'user#order_detail'
  get 'agency/buycar' => 'agency#buy_car'
  get 'user/buycarrequest' => 'user#buy_car_request'
  get 'agency/newcarowner' => 'agency#new_car_owner'

  post 'agency/inputnewcarowner' => 'agency#input_new_car_owner'
  post 'user/signin' => 'user#sign_in'
  post 'user/createuser' => 'user#create_user'
  post 'user/addpoint' => 'user#add_point_by_code'
  post 'mall/createshipping' => 'mall#create_shipping'
  post 'agency/inputbuycarinfo' => 'agency#input_buy_car_info'
  post 'user/update_profile' => 'user#update_profile'
  post 'user/create_address' => 'user#create_address'


  patch 'user/update_user' => 'user#update_user'


  #admin
  get 'panda/login' => 'panda#login'
  get 'panda/index' => 'panda#index'
  get 'panda/generatecode' => "panda#generate_code"
  get 'panda/passbuycarrequest' => 'panda#pass_buy_car_request'
  get 'panda/orderlist' => 'panda#order_list'
  get 'panda/order/:id' => 'panda#order_detail'
  get 'panda/signout' => 'panda#sign_out'
  get 'panda/carowner' => 'panda#car_owner'
  get 'panda/passcarowner' => 'panda#pass_car_owner'
  get 'panda/change_order_status' => 'panda#change_order_status'
  
  post 'panda/signin' => 'panda#sign_in'

end
