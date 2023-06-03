Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/", to: "application#welcome"

  get "/merchants/:merchant_id/dashboard", to: "merchants#show"
  get "/merchants/:merchant_id/invoices", to: "merchant_invoices#index"
  get "/merchants/:merchant_id/invoices/:invoice_id", to: "merchant_invoices#show"
  get "/merchants/:merchant_id/items", to: "merchant_items#index"
  get "/merchants/:merchant_id/items/:item_id", to: "merchant_items#show"
  get "/merchants/:merchant_id/items/:item_id/edit", to: "merchant_items#edit"
  patch "/merchants/:merchant_id/items/:item_id/", to: "merchant_items#update"

  get "/admin", to: "admin#index"

  namespace :admin do
    resources :merchants, except: [:destroy]
    resources :invoices, except: [:destroy]
  end
end
