Rails.application.routes.draw do
  devise_for :users

  get '/home', to: 'home#index', as: :home
  get 'events/archive', to: 'events#archive', as: :archive
  get 'users/:id' => 'users#show'
  # get '/events/:id' => 'events#edit'
  resources :events, except: [:show]
  resources :rooms
  resources :users

  root to: 'rooms#index'
end
