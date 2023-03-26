Rails.application.routes.draw do
  root 'craftmans#index'

  #devise
  devise_for :users, controllers: { registrations: 'registrations' }

  #letter_open_web
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
