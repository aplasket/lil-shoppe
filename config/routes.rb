Rails.application.routes.draw do
  root "application#welcome"

  resources :merchants, only: [] do
    resources :invoices, only: [:index, :show], controller: "merchant/invoices"
    resources :items, only: [:index, :show, :edit, :update], param: :item_id, controller: "merchant/items"
    resource :dashboard, only: [:show], controller: "merchants"
  end

  resources :admin, only: [:index]

  resources :invoices, only: [:update]

  namespace :admin do
    resources :merchants, only: [:index, :show, :edit, :update, :new, :create]
    resources :invoices, only: [:index, :show, :update]
  end
end
