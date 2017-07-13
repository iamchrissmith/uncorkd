Rails.application.routes.draw do
  root to: "home#show"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/twilio-confirmation", to: "twilio_confirmation#new"
  post "twilio-confirmation", to: "twilio_confirmation#create"

  resources :users, only: [:show, :create, :new, :edit, :update]
end
