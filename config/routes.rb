# frozen_string_literal: true

# This is a sample class representing an Route.
Rails.application.routes.draw do
  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'
  resources :sessions
  resources :users
  resources :passwords, only: %i[edit update]
  resources :items
  scope '/admin' do
    resources :admin, :categories
  end
  resources :conversations, only: %i[index show create] do
    resources :messages, only: [:create]
  end
  resources :items do
    resources :reviews, only: [:create]
  end
  mount ActionCable.server => '/cable'

  root 'welcome#index'
  post '/items/:id', to: 'admin#approved', as: 'submit'
  post '/items/:id/interested', to: 'notifications#interested', as: 'interested'
  get '/notifications/count', to: 'notifications#count'
  post '/notifications/mark_read', to: 'notifications#mark_read'
  get '/auth/facebook/callback', to: 'sessions#facebook_login'
  get '/items/:id', to: 'items#show', as: 'product'
  get 'search_items', to: 'welcome#search', as: 'search_items'
end
