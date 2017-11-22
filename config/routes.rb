Rails.application.routes.draw do
  devise_for :users

  get '/home', to: 'home#index', as: :home
  get 'users/:id' => 'users#show'
  get '/event/assist' => 'events#assist'
  resources :events
  resources :rooms
  resources :orders
  resources :users

  root to: 'rooms#index'
end
