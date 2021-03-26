Rails.application.routes.draw do

  get 'sessions/new'
  resources :events
  get '/feed', to: 'static_pages#feed'
  get '/create_review', to: 'reviews#new'
  get '/create_event', to: 'events#new'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/home', to: 'users#show'

  get '/friendship', to: 'friendship#index'
  put '/friendship', to: 'friendship#accept_friend'
  post '/friendship', to: 'friendship#create'
  delete '/friendship', to: 'friendship#decline_friend'
  get '/result', to: 'friendship#result'
  

  resources :friend_reviews, :friendship, :reviews, :users, :events
  root :to => 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
