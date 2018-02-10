Rails.application.routes.draw do
  devise_for :users

  get 'events/personal', to: 'events#personal', as: :personal_current
  get 'events/personal/:state', to: 'events#personal', as: :personal
  resources :events, except: [:show]

  get 'rooms/admin_index', to: 'rooms#admin_index', as: :admin_index
  get 'rooms/print/:id', to: 'rooms#show_print', as: :print
  resources :rooms

  root to: 'rooms#index'
end
