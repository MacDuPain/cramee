Rails.application.routes.draw do
  # Route racine de l'application, pointant vers le contrôleur 'static_pages' et l'action 'landing_page'
  root 'static_pages#landing_page'

  # Route pour la page 'À propos', accessible via /static_pages/about et avec le helper 'about_path'
  get 'static_pages/about', as: 'about'

  # Route pour les mentions légales, pointant vers le contrôleur 'static_pages' et l'action 'mentions_legales'
  get 'mentions_legales', to: 'static_pages#mentions_legales'

  # Route pour afficher un tag spécifique, pointant vers le contrôleur 'tags' et l'action 'show'
  get 'tags/show'

  # Route pour afficher les articles en stock, pointant vers le contrôleur 'items' et l'action 'stocked_items'
  get '/stocked_items', to: 'items#stocked_items'

  devise_for :users, controllers: {
  sessions: 'users/sessions',
  registrations: 'users/registrations',
  passwords: 'users/passwords'
}

  # Resource pour les utilisateurs, générant toutes les routes RESTful pour les utilisateurs
  resources :users

  # Resource pour les articles, générant toutes les routes RESTful pour les articles
  resources :items

  # Resource pour les paniers avec des routes personnalisées pour ajouter, supprimer des articles et confirmer une commande
  resources :carts, only: [:show, :create, :edit, :update, :destroy] do
    delete 'remove_item/:item_id', to: 'carts#remove_item', as: 'remove_item'
    post 'add_item/:item_id', to: 'carts#add_item', as: 'add_item'
    post 'confirm_order', to: 'carts#confirm_order', as: 'confirm_order'
    patch 'items/:id', to: 'carts#update_item_quantity', as: 'update_cart_item'
  end

  # Resource pour les commandes avec une action spécifique pour marquer une commande comme traitée
  resources :orders do
    member do
      put :mark_as_processed
    end
    resources :delivery_infos, only: [:new, :create]
  end

  # Scope pour les routes liées au processus de paiement/checkout
  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'create', to: 'checkout#create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  # Namespace admin pour les routes d'administration
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
  end

  # Route pour vérifier l'état de santé de l'application, utile pour les moniteurs de disponibilité
  get "up" => "rails/health#show", as: :rails_health_check

  # Routes pour le forum, avec une resource pour les sujets et des commentaires associés
  resources :topics do
    resources :comments, only: [:create]
  end

  # Route pour définir la page principale du forum comme l'index des sujets
  get 'forum', to: 'topics#index', as: 'forum'

  # Routes pour les tags, avec seulement l'action show disponible
  resources :tags, only: [:show]

  # Routes personnalisées pour les catégories spécifiques d'articles
  get 'boucles_oreilles', to: 'items#boucles_oreilles'
  get 'bracelets', to: 'items#bracelets'
  get 'colliers', to: 'items#colliers'
  get 'piece_unique', to: 'items#piece_unique'
  get 'marque_page', to: 'items#marque_page'
  get 'porte_cles', to: 'items#porte_cles'

  # Resource pour le profil utilisateur, avec seulement les actions show, edit et update disponibles
  resource :profile, only: [:show, :edit, :update]

  # Routes pour le livre d'or, avec seulement les actions new, create et index disponibles
  resources :reviews, only: [:new, :create, :index]
end
