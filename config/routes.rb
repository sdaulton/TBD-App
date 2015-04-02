Rails.application.routes.draw do

  resources :users

  root 'users#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
end
