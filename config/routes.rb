# frozen_string_literal: true

# This is a sample class representing an Route.
# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  root 'users#home_page'
  resources :sessions
  resources :users do
    collection do
      get :profile
    end
  end
  resources :admin do
    collection do
      get :approval_page
    end
    resources :categories do
      get '/page/:page', action: :index, on: :collection
    end
  end
  resources :passwords, only: %i[edit update]
  resources :items do
    get '/page/:page', action: :index, on: :collection
  end
  resources :conversations, only: %i[index show create] do
    resources :messages, only: [:create]
  end
  resources :items do
    resources :reviews, only: %i[create index]
  end
  mount ActionCable.server => '/cable'
  get '/auth/:provider/callback', to: 'sessions#omniauth'
  post '/items/:id', to: 'admin#approved', as: 'submit'
  post '/items/:id/interested', to: 'notifications#interested', as: 'interested'
  post '/notifications/mark_read', to: 'notifications#mark_read'
  get '/auth/facebook/callback', to: 'sessions#facebook_login'
  get '/items/:id', to: 'items#show', as: 'product'
  get 'search_items', to: 'items#elastic_search', as: 'search_items'
  get 'user_item', to: 'items#user_item'
  get 'user_pending_item', to: 'items#user_pending_item'
  get 'reset_password/new', to: 'reset_password#new', as: :new_reset_password
  post 'reset_password', to: 'reset_password#create'
  get 'reset_password/edit/:reset_password_token', to: 'reset_password#edit', as: :edit_reset_password
  patch 'reset_password', to: 'reset_password#update'
  get 'all_items', to: 'items#all_items'
  match '*unmatched', to: 'application#not_found_method', via: :all, constraints: lambda { |req|
    !req.path.match(%r{\A/rails/active_storage/})
  }
end
# rubocop:enable Metrics/BlockLength
