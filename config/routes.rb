Rails.application.routes.draw do
  get 'rentals/index'
  # get 'videos/index'
  # get 'videos/show'
  # get 'videos/create'
  # get 'customers/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :customers, only: [:index]

  resources :videos, only: [:index, :show, :create]

  resources :rentals, only: [:index]
end
