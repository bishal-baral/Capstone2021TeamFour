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
  post '/search', to: 'users#search'
  get '/friend_profile', to: 'users#friend_profile'
  post '/friend_profile', to: 'users#friend_profile'

  get '/add_tag/:id', to: 'reviews#tag'
  post '/add_tag/:id', to: 'reviews#add_tag'

  get 'sessions/new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  delete '/logout', to: 'sessions#destroy'
  
  get '/friendship', to: 'friendship#index'
  put '/friendship', to: 'friendship#accept_friend'
  post '/friendship', to: 'friendship#create'
  delete '/friendship', to: 'friendship#decline_friend'
  get '/result', to: 'friendship#result'
  
  resources :friend_reviews, :friendship, :reviews, :users, :events
  root :to => 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #for the video and controller
  # get 'video/landing'
  # get 'video/index'
  # get 'video/screenshare'
  # get 'video/name'
  # get 'video/chat'

  # get '/landing', to: 'video#landing'
  # post '/landing', to: 'video#landing'
  # get '/party', to: 'video#index'
  # post '/party', to: 'video#index'
  # get '/screenshare', to: 'video#screenshare'
  # post '/name', to: 'video#name'
  # post '/chat/send', to: 'video#chat'
  # post '/event', to: 'video#webhook'

  get '/landing', to: 'events#landing'
  post '/landing', to: 'events#landing'
  get '/party', to: 'events#index'
  post '/party', to: 'events#index'
  get '/screenshare', to: 'events#screenshare'
  post '/name', to: 'events#name'
  post '/chat/send', to: 'events#chat'
  post '/event', to: 'events#webhook'

  # get '/landing', to: 'event#landing'
  # get '/party', to: 'event#index'
  # get '/screenshare', to: 'event#screenshare'
  # post '/landing', to: 'event#landing'
  # post '/party', to: 'event#index'
  # post '/screenshare', to: 'event#screenshare'
  # post '/name', to: 'event#name'
  # post '/chat/send', to: 'event#chat'
  # post '/event', to: 'event#webhook'

end
