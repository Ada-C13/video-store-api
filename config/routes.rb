Rails.application.routes.draw do
  # get 'videos/#index'
  # get 'videos/#show'
  # get 'videos/#create'
  # get 'customers/#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :customers, only: [:index]
  resources :videos, only: [:index, :show, :create]
  post '/rentals/check-out', to: 'rentals#check_out'
  post '/rentals/check-in', to: 'rentals#check_in'
  # get '/zomg', to: 'application#show'

end
