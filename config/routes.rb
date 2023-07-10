Rails.application.routes.draw do
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  root "static_pages#home"

  get "static_pages/home"
  get "static_pages/help"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"

  # resources :users, only: %i(new create show)

  resources :users, only: :show
end
