Rails.application.routes.draw do
  resources :customers, only: [:index]

  resources :videos, only: [:index, :show, :create]

  post "/rentals/check-out/:customer_id/:video_id", to: "rentals#check_out", as: "check_out"
  post "/rentals/check-in/:customer_id/:video_id", to: "rentals#check_in", as: "check_in"
end

