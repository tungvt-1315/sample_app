# frozen_string_literal: true

Rails.application.routes.draw do
  root "static_pages#home"
  
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "static_pages/home"
  get "static_pages/help"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  
  resources :users#, only: :show
  resources :account_activations, only: :edit
  resources :password_resets, only: %i(new create edit update)
end
