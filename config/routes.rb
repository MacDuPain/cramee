Rails.application.routes.draw do
  root "items#index"

  devise_for :users

  resources :users

  resources :items do
    collection do
      get 'index'
    end
  end

  resources :carts, only: [:show, :create, :edit, :update, :destroy] do
    delete 'remove_item/:item_id', to: 'carts#remove_item', as: 'remove_item'
    post 'add_item/:item_id', to: 'carts#add_item', as: 'add_item'
    post 'confirm_order', to: 'carts#confirm_order', as: 'confirm_order'
  end

  resources :orders, only: [:show]

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
