Rails.application.routes.draw do
  get '/home', to: 'home#index', as: :home

  devise_for :users
  get 'users/' => 'users#events'
  get 'users/canceled/', to: 'users#canceled', as: :user_canceled
  get 'users/past/', to: 'users#past', as: :user_past
  # resources :users

  resources :events, except: [:show]
  get 'events/archive', to: 'events#archive', as: :archive
  get 'events/past', to: 'events#past', as: :past

  resources :rooms
  get 'rooms/print/:id', to: 'rooms#show_print', as: :print

  root to: 'rooms#index'
end
