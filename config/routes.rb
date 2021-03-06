Rails.application.routes.draw do
  # devise_for :users, :controllers => {
  #   :omniauth_callbacks => "users/omniauth_callbacks",
  #   sessions: "users/sessions" ,
  #   confirmations: "users/confirmations"
  #  }
  devise_for :users, :controllers => {
   :omniauth_callbacks => "users/omniauth_callbacks"
 }

  root "welcome#index"
  get '/contact' => 'welcome#contact', :as => "contact"
  namespace :admin do
    resources :products
    resources :categories
    resources :brands
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
    resources :users do
      member do
        post :to_admin
        post :to_normal
      end
    end
  end

  resources :products do
    # get ':param' => 'products#index'
    member do
      post :add_to_cart
    end
    collection do
      get 'men'
      get 'women'
      get 'kids'
      get 'categories'
      get 'brands'
      post 'sort'
      post 'modify_display_quantity'
      post 'search'
    end
  end
  post 'prodcuts' => 'products#index'

  resources :carts do
    collection do
      post :checkout
      delete :clean
    end
  end

  resources :photos

  resources :orders do
    member do
      get :pay_with_credit_card
     post :pay2go_atm_complete
     post :pay2go_cc_notify
    end
  end

  resources :items, controller: "cart_items"

  namespace :account do
    resources :orders
  end

  if Rails.env.development?
     mount LetterOpenerWeb::Engine, at: "/letter_opener"
   end
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
