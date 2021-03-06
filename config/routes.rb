Rails.application.routes.draw do

  resources :users
  get 'password_resets/new'

  get "/" => "home#index", as: :root
  get "/about" => "home#about"

  get "/posts/search" => "posts#search", as: :search

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  get "/users/reset/:id" => "users#edit_password", as: :reset
  patch "/users/reset/:id" => "users#update_password"
  get "/users/forgot/" => "users#forgot_password", as: :forgot
  resources :users, only: [:new, :create, :edit, :update]


  resources :posts do
    resources :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy], shallow: true
  end

  resources :favorites, only: [:index]
  resources :password_resets

  # get "/comments/new" => "comments#new", as: :new_comment
  # post "/comments" => "comments#create", as: :comments
  # get "/comments/:id" => "comments#show", as: :comment
  # get "/comments" => "comments#index"
  # get "/comments/:id/edit" => "comments#edit", as: :edit_comment
  # patch "/comments/:id" => "comments#update"
  # delete "/comments/:id" => "comments#destroy"
  # get "/comments/search" => "comments#search"



  # get "/comments/new" => "comments#new"
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
