Rails.application.routes.draw do

  root "movies#index"
  
  resources :movies do
    resources :reviews  
  end
  
  resources :users
  get "sign-up" => "users#new"

  resource :session, only: [:new, :create, :destroy]
  get "sign-in" => "sessions#new"

end