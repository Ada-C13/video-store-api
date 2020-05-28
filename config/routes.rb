Rails.application.routes.draw do
  resources :videos, only: [:index, :show, :create] 
  resources :customers, only: [:index]

  post "/rentals/checkout", to: "rentals#checkout", as: "checkout"
  post "/rentals/checkin", to: "rentals#checkin", as: "checkin"
end
