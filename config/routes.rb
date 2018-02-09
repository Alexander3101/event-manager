Rails.application.routes.draw do
  get '/home', to: 'home#index', as: :home

  devise_for :users

  resources :events, except: [:show]
  get 'events/personal', to: 'events#personal', as: :personal_current
  get 'events/personal/:state', to: 'events#personal', as: :personal

  resources :rooms
  get 'rooms/print/:id', to: 'rooms#show_print', as: :print

  root to: 'rooms#index'
end
