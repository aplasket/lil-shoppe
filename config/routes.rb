Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "application#welcome"

  resources :merchants, only: [] do
    resources :invoices, only: [:index], controller: "merchant/invoices"
    resources :items, only: [:index, :show, :edit, :update], param: :item_id, controller: "merchant/items" do
      member do
        patch :disable, to: "merchant/items#update_status"
        patch :enable, to: "merchant/items#update_status"
      end
    end
    resource :dashboard, only: [:show], controller: "merchants"
  end

  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants, only: [:index, :show, :edit, :update]
    resources :invoices, only: [:index, :show]
  end
end
