Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  post 'notifications/notify' => 'notifications#notify'
  
  devise_for :users
  resources :users
  resources :promotions do
    resources :charges
    member do
      get :confirmed
      get :pause
    end
    collection do
      get :expired
    end
  end
root 'promotions#index'
end
