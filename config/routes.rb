Rails.application.routes.draw do

  resources :events
  get '/feed', to: 'static_pages#feed'
  get '/create_review', to: 'reviews#new'
  get '/create_event', to: 'events#new'

  resources :friend_reviews, :friends, :reviews, :users, :events
  root :to => 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
