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

  resources :rides do
    get 'location'
    get 'driver_enroute'
    get 'picked_up'
    get 'dropped_off'
    get 'wait_for_location'
    get 'drive_to_pickup'
    get 'pickup_rider'
    get 'dropoff_rider'
  end
  
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
end
