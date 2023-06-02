Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/", to: "application#welcome"

  get "/admin", to: "admin#index"

  namespace :admin do
    resources :merchants, except: [:destroy]
    resources :invoices, except: [:destroy]
  end
end
