Rails.application.routes.draw do
  get '/home', to: 'home#index', as: :home

  devise_for :users
  get 'users/:id' => 'users#show'
  get 'users/archive/:id', to: 'users#archive', as: :user_archive
  
  resources :events, except: [:show]
  get 'events/archive', to: 'events#archive', as: :archive

  resources :rooms

  root to: 'rooms#index'
end
