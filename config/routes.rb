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
    resources :categories
  end
  resources :conversations, only: %i[index show create] do
    resources :messages, only: [:create]
  end
  resources :items do
    resources :reviews, only: [:create]
  end
  mount ActionCable.server => '/cable'
  root 'welcome#index'
  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'
  post '/items/:id', to: 'admin#approved', as: 'submit'
  post '/items/:id/interested', to: 'notifications#interested', as: 'interested'
  post '/notifications/mark_read', to: 'notifications#mark_read'
  get '/auth/facebook/callback', to: 'sessions#facebook_login'
  get '/items/:id', to: 'items#show', as: 'product'
  get 'search_items', to: 'items#elastic_search', as: 'search_items'
  get 'profile', to: 'users#profile'
  get 'admin', to: 'admin#admin'
end
# rubocop:enable Metrics/BlockLength
