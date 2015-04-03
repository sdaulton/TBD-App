Rails.application.routes.draw do

  #resources :users

  root 'users#index'

  get "/users/index"
  get "/users/register"
  get "/users/login"
  get "/users/logging"
  get "/users/edit/:id", to: 'users#edit', as: "edit_user"
  put "/users/update/:id", to: 'users#update' 
  patch "/users/update/:id", to: 'users#update', as: "update_user"
  get "/users/welcome/:id", to: 'users#welcome', as: "welcome_user"
  
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
end
