Rails.application.routes.draw do
  root to: 'home#top'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/posts/search', to: 'posts#search'
  # get 'gifts/pay', to: 'gifts#pay'
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
  resources :gifts, only: [:show, :new, :destroy] do
    collection do
      post 'show', to: 'gifts#show'
      post 'pay', to: 'gifts#pay'
    end
  end
  resources :notifications, only: [:index]
end
