Rails.application.routes.draw do
  root to: "home#show"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/twilio-confirmation", to: "twilio_confirmation#new"
  post "twilio-confirmation", to: "twilio_confirmation#create"

  resources :users, only: [:show, :create, :new, :edit, :update]
  resources :venues, only: [:index, :show]
  namespace :manager do
    resources :venues, only: [:index, :show, :new, :create, :edit, :update]
  end
  resources :wines, only: [:index, :show] do
    get '/add_to_venues', to: "venue_wines#new"
    post '/add_to_venues', to: "venue_wines#create"
    get '/edit_venues', to: "venue_wines#edit"
    post '/edit_venues', to: "venue_wines#update"
  end
end
