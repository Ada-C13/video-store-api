Rails.application.routes.draw do

  resources :rentals
  resources :customers, only: [:index, :create, :show]
  resources :videos, only: [:index, :create, :show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
