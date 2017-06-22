Rails.application.routes.draw do
  root to: 'home#index'
  get '/home', to: 'home#index', as: :home
  resources :events
  resources :rooms
  resources :orders

end
