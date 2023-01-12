Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    # resources :places
    get '/nearby', to: "places#nearby"
    get '/findme', to: "places#findme"

  end

  
end
