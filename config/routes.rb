Rails.application.routes.draw do

  #resources :users

  root 'users#index'

  #get "/users/index"
  #get "/users/register"
  #get "/users/login"
  #get "/users/logging"
  #get "/users/new", to: 'users#new', as: "new_user"
  #post "/users/create", to: 'users#create', as: "create_user"
  #get "/users/edit/:id", to: 'users#edit', as: "edit_user"
  #put "/users/update/:id", to: 'users#update' 
  #patch "/users/update/:id", to: 'users#update', as: "update_user"
  #get "/users/welcome/:id", to: 'users#welcome', as: "welcome_user"

  #post "/users/drivers/create", to: 'drivers#create', as: "new_driver"

  resources :users do
    resources :riders do
      get 'first'
      get 'num'
    end
    resources :drivers do
      get 'first'
      get 'num'
    end
    get 'welcome', :on => :member
  end
  
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
end
