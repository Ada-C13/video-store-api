Rails.application.routes.draw do
  resources :customers, only: [:index]
  resources :videos, only: [:index, :show, :create]
  
  post '/rentals/check-in', to: 'rentals#checkin', as: 'check_in'
  post '/rentals/check-out', to: 'rentals#checkout', as: 'check_out'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
