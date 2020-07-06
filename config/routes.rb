Rails.application.routes.draw do
  root to: 'home#top'
  get 'signup', to: 'users#new'
  resources :users
end
