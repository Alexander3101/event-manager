Rails.application.routes.draw do
  devise_for :users

  get '/home', to: 'home#index', as: :home
  get 'users/:id' => 'users#show'
  # get '/events/:id' => 'events#edit'
  resources :events, except: [:show]
  resources :rooms
  resources :users

  root to: 'rooms#index'
end
