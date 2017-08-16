Rails.application.routes.draw do

  ActiveAdmin.routes(self)

  namespace :admin do
    resources :users do
      resources :products
      resources :videos
      resources :photos
      resources :ratings
      resources :companies
      resources :reviews
    end
    resources :father_categories do
      resources :categories
    end
    resources :categories do
      resources :sub_categories
      resources :photos
      resources :videos
      resources :users
    end
    resources :sub_categories do
      resources :products
    end
    resources :companies do
      resources :products
      resources :users
    end
    resources :products do
      resources :videos
      resources :photos
      resources :prices
      resources :ratings
      resources :reviews
      resources :users
    end
    resources :videos do
      resources :users
    end
    resources :photos do
      resources :users
    end
    resources :distributors do
      resources :companies
    end
  end

  root to: 'home#index'
  devise_for :users, :controllers => { registrations: 'registrations'}
  resources :users do
    collection do
      get :review
      get :photo
      get :video
    end
  end
  get 'ajax_destroy_recent_search', to: 'users#ajax_destroy_recent_search', as: :ajax_destroy_recent_search
  get 'ajax_destroy_favourite', to: 'users#ajax_destroy_favourite', as: :ajax_destroy_favourite
  get 'ajax_destroy_all_favourites', to: 'users#ajax_destroy_all_favourites', as: :ajax_destroy_all_favourites
  get 'ajax_destroy_recent_searches', to: 'users#ajax_destroy_recent_searches', as: :ajax_destroy_recent_searches
  get 'ajax_get_filter_options/:id' => 'products#set_filter_options', as: :set_filter_options

  resources :home, only: [:index]
  resources :search, only: [:index]
  resources :sub_categories, only: [:show]
  resources :products, only: [:show] do
    resources :reviews, only:[:new, :create], defaults: {format: :json}
    resources :user_favourite_products, only:[:add, :remove] do
      collection do
        get 'add'
        get 'remove'
      end
    end
  end

  resource :pictures, format: false, only: :create
  resources :photos, format: false, only: [:create, :show]
  resources :videos, format: false, only: [:create, :show]

  # controller :favourites, as: :favourite, path: :favourites,
  #            format: true, constraints: { format: :json } do
  #   %i(products photos videos).each do |type|
  #     defaults type: type do
  #       post type, to: :create
  #       delete type, to: :destroy
  #     end
  #   end
  # end

  post '/modals/:action', controller: :modals, format: false, as: :modals
  get '/modals/fetch' => 'modals#fetch', format: :json
end
