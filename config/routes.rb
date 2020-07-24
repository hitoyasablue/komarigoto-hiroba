Rails.application.routes.draw do
  root to: 'home#top'
  get '/signup', to: 'users#new'
  get '/posts/search', to: 'posts#search'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :wakarus, only: [:create, :destroy]
    resources :progresses, only: [:new, :create, :show, :edit, :update, :destroy]
  end
  resources :notifications, only: [:index]
end
