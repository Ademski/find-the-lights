Rails.application.routes.draw do
  resources :light_displays

  root to: 'light_displays#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
end
