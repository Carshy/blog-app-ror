Rails.application.routes.draw do
  devise_for :users, sign_out_via: [:get, :post]

  namespace :api do
    resources :users do
      resources :posts do
      resources :comments
      end
    end
  end

  post 'auth/login', to: 'authentication#login'
  post 'auth/signup', to: 'authentication#signup'

  root 'users#index'
  resources :users do
    resources :posts do
      resources :comments
      resources :likes
      end
  end
end
