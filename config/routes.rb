Rails.application.routes.draw do

  get '/feed', to: 'static_pages#feed'
  get '/events', to: 'static_pages#events'

  resources :friend_reviews
  resources :friends
  resources :reviews
  resources :users
  root :to => 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
