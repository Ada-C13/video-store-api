Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :videos, only:[:index, :show, :create]
  resources :customers, only:[:index]
  post '/rentals/check-out', to: 'rentals#checkin', as: 'check_out'
  post '/rentals/check-in', to: 'rentals#checkout', as: 'check_in'
  

end
