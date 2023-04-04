Rails.application.routes.draw do
  root 'craftmen#index'
  resources :candidates
  resources :products
  resources :craftmen

  #chatGPT
  resources :chats, only: [:index] do
    post 'search', on: :collection, defaults: { format: :json }
    post 'generated_text', on: :collection, defaults: { format: :json }, as: 'generated_text'
  end
  # resources :chats テスト実装用
  # get 'search', to: 'chats#search'
  
  #guest log in
  post 'guest_sign_in', to: 'guest_sessions#create'
  
  #devise
  devise_for :users, controllers: { registrations: 'registrations' }
  
  #rails_admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  #letter_open_web
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
