Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :sessions, only: [:create]
  resources :posts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end

