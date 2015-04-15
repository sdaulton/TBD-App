Rails.application.routes.draw do


  root 'users#index'

  resources :users do
    resources :riders do
      get 'wait'
    end
    resources :drivers do
      get 'wait'
    end
    get 'welcome', :on => :member
  end
  
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
end
