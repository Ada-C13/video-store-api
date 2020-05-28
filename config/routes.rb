Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :videos, only: [:index, :show, :create]
  resources :customers, only: [:index]
  resources :rentals, only: [:create, :destroy]

  post "/rentals/check-out", to: "rentals#create", as: "check-out"
  post "/rentals/check-in", to: "rentals#destroy", as: "check-in"
end
