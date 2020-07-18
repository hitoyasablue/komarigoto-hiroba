Rails.application.routes.draw do
  root to: 'home#top'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :posts do
    resources :likes, only: [:create, :destroy]
  end
end
