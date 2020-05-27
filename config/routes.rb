Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 
  resources :videos, only: [:index, :create, :show] do
    resources :rentals
  end
  resources :customers, only: [:index, :create, :show] do
    resources :rentals
  end

  post 'rentals/checkout/', to: "rentals#checkout", as: "checkout"
  post 'rentals/checkoin/', to: "rentals#checkin", as: "checkin"
  # get "/zomg", to: " ", as: "zomg"

end
