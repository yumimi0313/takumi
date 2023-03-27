Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'craftmans#index'

  #devise
  devise_for :users, controllers: { registrations: 'registrations' }

  #letter_open_web
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
