Rails.application.routes.draw do
  root 'craftmen#index'
  resources :candidates
  resources :products, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :craftmen
  resources :relationships, only: [:create, :destroy]

  #message
  resources :conversations do
    resources :messages
  end
  
  #devise
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: [:show, :edit, :update]
  
  #rails_admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  #guest log in
  # post 'guest_sign_in', to: 'guest_sessions#create'

  #letter_open_web
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
