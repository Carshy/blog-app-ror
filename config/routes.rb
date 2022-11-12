Rails.application.routes.draw do
  devise_for :users, sign_out_via: [:get, :post]

  namespace :api do
    resources :users do
      resources :posts do
      resources :comments
      end
    end
  end

  root 'users#index'
  resources :users do
    resources :posts do
      resources :comments
      resources :likes
      end
  end
end
