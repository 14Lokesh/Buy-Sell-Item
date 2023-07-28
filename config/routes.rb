# frozen_string_literal: true

# This is a sample class representing an Route.
# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  resources :sessions
  resources :users
  scope '/approval_page' do
    resources :admin
  end
  resources :passwords, only: %i[edit update]
  resources :items do
    get '/page/:page', action: :index, on: :collection
  end
  scope '/admin' do
    resources :categories do
      get '/page/:page', action: :index, on: :collection
    end
  end
  resources :conversations, only: %i[index show create] do
    resources :messages, only: [:create]
  end
  resources :items do
    resources :reviews, only: %i[create index]
  end
  #  resources :reset_password, only: %i[new create edit update]
  mount ActionCable.server => '/cable'
  root 'users#home_page'
  get '/auth/:provider/callback', to: 'sessions#omniauth'
  post '/items/:id', to: 'admin#approved', as: 'submit'
  post '/items/:id/interested', to: 'notifications#interested', as: 'interested'
  post '/notifications/mark_read', to: 'notifications#mark_read'
  get '/auth/facebook/callback', to: 'sessions#facebook_login'
  get '/items/:id', to: 'items#show', as: 'product'
  get 'search_items', to: 'items#elastic_search', as: 'search_items'
  get 'profile', to: 'users#profile'
  get 'admin', to: 'admin#admin'
  get 'user_item', to: 'items#user_item'
  get 'user_pending_item', to: 'items#user_pending_item'
  get 'reset_password/new', to: 'reset_password#new', as: :new_reset_password
  post 'reset_password', to: 'reset_password#create'
  get 'reset_password/edit/:reset_password_token', to: 'reset_password#edit', as: :edit_reset_password
  patch 'reset_password', to: 'reset_password#update'
end
# rubocop:enable Metrics/BlockLength
