# frozen_string_literal: true

Rails.application.routes.draw do
  # Events controller's routes
  get '/create_event', to: 'events#new'
  get '/events', to: 'events#show'
  post '/events', to: 'events#create'
  get '/event_screen', to: 'events#event_screen'
  post '/event_screen', to: 'events#event_screen'
  get '/party', to: 'events#index'
  post '/party', to: 'events#index'
  get '/screenshare', to: 'events#screenshare'
  post '/screenshare', to: 'events#screenshare'
  post '/name', to: 'events#name'
  post '/chat/send', to: 'events#chat'
  post '/event', to: 'events#webhook'
  # get '/leave_event', to: 'events#leave_event'

  # Users controller's routes
  get '/profile', to: 'users#profile'
  post '/upload_avatar', to: 'users#avatar', defaults: { format: 'js' }
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/home', to: 'users#show'
  post '/search', to: 'users#search'
  get '/friend_profile', to: 'users#friend_profile'
  post '/friend_profile', to: 'users#friend_profile'

  # Reviews controller's routes
  get '/create_review', to: 'reviews#new'
  get '/add_tag/:id', to: 'reviews#tag'
  post '/add_tag/:id', to: 'reviews#add_tag'

  # Sessions controller's routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  delete '/logout', to: 'sessions#destroy'

  # Friendship controller's routes
  get '/friendship', to: 'friendship#index'
  put '/friendship', to: 'friendship#accept_friend'
  post '/friendship', to: 'friendship#create'
  delete '/friendship', to: 'friendship#decline_friend'
  get '/result', to: 'friendship#result'

  # delete this
  resources :friend_reviews, :friendship, :reviews, :users, :events

  # Notifications controller's routes
  resources :notifications do
    collection do
      post :mark_as_read
    end
  end
  root to: 'home#index'
end
