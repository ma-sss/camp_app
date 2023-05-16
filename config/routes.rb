Rails.application.routes.draw do
  get "/" => "homes#top"
  get "reservations/user_reservations" => "reservations#user_reservations"
  get "admins/admin_reservations" => "admins#admin_reservations"
  
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
  
  resources :admins, expect: [:index]
  
  resources :favorites, only: [:index, :create, :destroy]

  resources :users, only: [:show, :edit, :update] do
  end

  end