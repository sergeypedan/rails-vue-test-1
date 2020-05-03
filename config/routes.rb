# frozen_string_literal: true

Rails.application.routes.draw do

  root to: "home#index"

  namespace :api do
    namespace :v1 do
      resources :artists
      resources :records
    end
  end

  post   "/refresh", to: "refresh#create"
  post   "/signin",  to: "sessions#create"
  delete "/signin",  to: "sessions#destroy"
  post   "/signup",  to: "users#create"

  # Fallbacks for page refresh
  get "/artists", to: "home#index"
  get "/records", to: "home#index"
  get "/signup",  to: "home#index"

end
