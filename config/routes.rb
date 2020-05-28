Rails.application.routes.draw do

  resources :rentals
  resources :customers, only: [:index, :create, :show]
  resources :videos, only: [:index, :create, :show]

  post "/rentals/check-out", to: "rentals#check_out", as: "check-out"
  post "/rentals/check-in", to: "rentals#check_in", as: "check-in"

  root "videos#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
