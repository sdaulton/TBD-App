Rails.application.routes.draw do

  resources :users

  root 'users#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
