Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get '/home', to: 'home#index', as: :home
  get 'users/personal', as: 'user_root'
  resources :events
  resources :rooms
  resources :orders
end
