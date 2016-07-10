Rails.application.routes.draw do


  resources :resumes, only: [:index, :new, :create, :destroy]

  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}

  resources :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # You can have the root of your site routed with "root"
  # root 'welcome#index'


  root 'teams#index'
  resources :teams, only: [:create, :index, :new] do
    member do
      patch :adding
      get :adding
      get :addmember
      patch :change_etc1
      patch :change_etc2
      patch :deletemember
    end

    collection do
      get :profile
      patch :profileupdate
      get :search
      get :noteam
    end
  end
  #post '/team/deletemember' => 'teams#deletemember'

  #post '/team/profileupdate' => 'teams#profileupdate'
  #post '/team/change_etc1' => 'teams#change_etc1'
  #post '/team/change_etc2' => 'teams#change_etc2'



  resources :chats, only: [:index, :create] do

    member do
      patch :deletemember
      patch :addmember
    end

  end

  #get '/chat/show' => 'chat#show'
  #post '/chat/create' => 'chat#create'
  resources :messages, only: [:index, :create, :update] do

    collection do
      post :fileup
      post :imageup
      patch :updateall
    end


  end


  #post '/imageup' => 'messages#imageup'
  #post '/fileup' => 'messages#fileup'

  put '/whiteboard/update' => 'whiteboard#update'
  post '/whiteboard/update2' => 'whiteboard#update2'

  resources :tasks, only: [:index, :create] do
    member do
      patch :wansungdo_update
    end
  end
=begin
  post '/task/create' => 'task#create'
  get '/task/show' => 'task#show'
  post '/task/wansungdo_update' => 'task#wansungdo_update'
=end


  post '/test/index' => 'test#index'
  get '/test/index' => 'test#index'
  get '/test/invitation' => 'test#invitation'
  post '/test/regmail' => 'test#regmail'
  get '/test/regmailshow' => 'test#regmailshow'

  get '/test/authfail' => 'test#authfail'








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
