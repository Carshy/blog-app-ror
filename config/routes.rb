Rails.application.routes.draw do
  devise_for :users, sign_out_via: [:get, :post]

  
  root 'users#index'
  resources :users do
    resources :posts do
      resources :comments
      resources :likes
      end
  end
end
