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
    resources :teineis, only: [:create, :destroy]
    resources :ouens, only: [:create, :destroy]
    resources :progresses do
      resources :erais, only: [:create, :destroy]
      resources :sounandas, only: [:create, :destroy]
      resources :ouen2s, only: [:create, :destroy]
      resources :teinei2s, only: [:create, :destroy]
    end
  end
  resources :notifications, only: [:index]
end
