Rails.application.routes.draw do
  get '/home', to: 'home#index', as: :home

  devise_for :users
  get 'users/:id' => 'users#show'
  get 'users/archive/:id', to: 'users#archive', as: :user_archive
  resources :users

  resources :events, except: [:show]
  get 'events/archive', to: 'events#archive', as: :archive

  resources :rooms
  get 'rooms/print/:id', to: 'rooms#show_print', as: :print

  root to: 'rooms#index'
end
