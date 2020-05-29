Rails.application.routes.draw do
  resources :customers, only:[:index, :show]

  resources :videos, only:[:index, :show, :create]

  post '/rentals/check-out', to: 'rentals#check_out', as: "checkout"
  post '/rentals/check-in', to: 'rentals#check_in', as: "checkin"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
