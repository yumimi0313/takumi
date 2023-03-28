Rails.application.routes.draw do
  root 'craftmans#index'
  
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
