Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  resources :posts do
    resources :goods,    only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
end
