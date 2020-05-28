Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 
  resources :videos, only: [:index, :create, :show] do
    resources :rentals
  end
  resources :customers, only: [:index, :create, :show] do
    resources :rentals
  end

  post 'rentals/check-out/', to: "rentals#checkout", as: "check-out"
  post 'rentals/check-in/', to: "rentals#checkin", as: "check-in"
  # get "/zomg", to: " ", as: "zomg"

end
