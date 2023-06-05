Rails.application.routes.draw do
  root "application#welcome"

  resources :merchants, only: [] do
    resources :invoices, only: [:index], controller: "merchant/invoices"
    resources :items, only: [:index, :show, :edit, :update, :new, :create], controller: "merchant/items"
    resource :dashboard, only: [:show], controller: "merchants"
  end

  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants, only: [:index, :show, :edit, :update]
    resources :invoices, only: [:index, :show]
  end
end
