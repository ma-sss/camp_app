Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  namespace :user do
    resources :sessions, only: %i[index]
  end


  resources :admins, :only => [:index, :show] do
    resources :reservations
  end

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'user', controllers: {
        registrations: 'api/v1/users/registrations'
      }
      resources :admins, :only => [:index, :show, :create, :destroy] do
        resources :reservations
      end
    end
  end

  get "/" => "homes#top"
  get "reservations/user_reservations" => "reservations#user_reservations"
  get "admins/admin_reservations" => "admins#admin_reservations"
  
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  
  resources :admins, expect: [:index]
  
  resources :favorites, only: [:index, :create, :destroy]

  resources :users, only: [:show, :edit, :update] do
  end

  end