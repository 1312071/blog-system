Rails.application.routes.draw do
  root "home#index"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :entries
  namespace :entries do
    resources :comments
  end
  resources :follows do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
end
