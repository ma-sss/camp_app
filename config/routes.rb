Rails.application.routes.draw do
  get '/' => 'homes#top'
  
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  resources :admins, :only => [:index, :show] do
    resources :reservations
  end

  resources :favorites, only: [:index, :create, :destroy]
  end