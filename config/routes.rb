Rails.application.routes.draw do
  get '/rentals', to: 'rentals#index', as: 'rentals_index'
  # get 'videos/index'
  # get 'videos/show'
  # get 'videos/create'
  # get 'customers/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :videos, only: [:index, :show, :create]
  
  resources :customers, only: [:index]

  post '/rentals/check-out', to: 'rentals#check_out', as: 'check_out'
  post '/rentals/check-in', to: 'rentals#check_in', as: 'check_in'

  # resources :rentals, only: [:index]
end
