Rails.application.routes.draw do
  resources :customers, only: [:index]

  resources :videos, only: [:index, :show, :create]
  
  post '/rentals/check_out', to: 'rentals#check_out', as: 'check_out'
  post '/rentals/check_out', to: 'rentals#check_out', as: 'check_in'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
