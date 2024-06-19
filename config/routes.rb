Rails.application.routes.draw do
  root 'static_pages#landing_page'
  get 'static_pages/about', as: 'about'
  get 'mentions_legales', to: 'static_pages#mentions_legales'
  get 'tags/show'
  get '/stocked_items', to: 'items#stocked_items'

  devise_for :users

  resources :users

  resources :items

  resources :carts, only: [:show, :create, :edit, :update, :destroy] do
    delete 'remove_item/:item_id', to: 'carts#remove_item', as: 'remove_item'
    post 'add_item/:item_id', to: 'carts#add_item', as: 'add_item'
    post 'confirm_order', to: 'carts#confirm_order', as: 'confirm_order'
    patch 'items/:id', to: 'carts#update_item_quantity', as: 'update_cart_item'
    member do
      patch 'items/:item_id', to: 'carts#update_item_quantity', as: 'update_item_quantity'
    end

  end

  resources :orders do
    member do
      put :mark_as_processed
    end
    resources :delivery_infos, only: [:new, :create]
  end

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'create', to: 'checkout#create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Routes pour le forum
  resources :topics do
    resources :comments, only: [:create]
  end

  # Si vous voulez que la page principale du forum soit l'index des topics
  get 'forum', to: 'topics#index', as: 'forum'

  # Routes pour les tags et catégories
  resources :tags, only: [:show]

  # Custom item categories routes
  get 'boucles_oreilles', to: 'items#boucles_oreilles'
  get 'bracelets', to: 'items#bracelets'
  get 'colliers', to: 'items#colliers'
  get 'piece_unique', to: 'items#piece_unique'
  get 'marque_page', to: 'items#marque_page'
  get 'autres', to: 'items#autres'

  # Profile route
  resource :profile, only: [:show, :edit, :update]

  #Routes livre d'or
  resources :reviews, only: [:new, :create, :index]


end
