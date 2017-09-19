Rails.application.routes.draw do
  root to: "home#show"

  get "users/verify", to: 'users#show_verify', as: 'verify'
  post "users/verify"
  post "users/resend"

  get '/auth/facebook', as: 'facebook_login'
  get "auth/facebook/callback", to: "sessions#create"
  get "auth/failure", to: redirect("/")

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  namespace :users do
    resources :reviews, only: [:new, :create]
    get '/profile', to: 'profile#show'
  end

  namespace :api do
    namespace :v1 do
      get '/wine', to: 'wines#index'
    end
  end

  resources :users, only: [:show, :create, :new, :edit, :update] do
    resources :follows, only: [:create, :destroy]
  end

  resources :venues, only: [:index, :show]

  namespace :manager do
    resources :venues, only: [:index, :show, :new, :create, :edit, :update]
  end

  namespace :admin do
    resources :users, only: [:index, :update]
    resources :venues, only: [:index, :destroy]
    resources :wines, only: [:index, :destroy]
    get '/dashboard', to: 'admin#show'
  end



  resources :wines, only: [:index, :show] do
    get '/add_to_venues', to: "venue_wines#new"
    post '/add_to_venues', to: "venue_wines#create"
    get '/edit_venues', to: "venue_wines#edit"
    post '/edit_venues', to: "venue_wines#update"
  end
end
