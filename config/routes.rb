Rails.application.routes.draw do
  get '/create_review', to: 'reviews#new'

  get '/create_event', to: 'events#new'
  get '/events', to: 'events#show'
  post '/events', to: 'events#create'
  get '/event_screen', to: 'events#event_screen'
  post '/event_screen', to: 'events#event_screen'

  get '/profile', to: 'users#profile'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/home', to: 'users#show'
  get '/profile', to: 'users#profile'
  get '/friend_profile', to: 'users#friend_profile'
  post '/friend_profile', to: 'users#friend_profile'

  get '/add_tag/:id', to: 'reviews#tag'
  post '/add_tag/:id', to: 'reviews#add_tag'

  get 'sessions/new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/friendship', to: 'friendship#index'
  put '/friendship', to: 'friendship#accept_friend'
  post '/friendship', to: 'friendship#create'
  delete '/friendship', to: 'friendship#decline_friend'
  get '/result', to: 'friendship#result'
  
  resources :friend_reviews, :friendship, :reviews, :users, :events
  root :to => 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
