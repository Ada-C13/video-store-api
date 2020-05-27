Rails.application.routes.draw do
  # get "/zomg", to: "videos#index", as: "index"
  resources :customers, only: [:index]
  resources :videos, only: [:index, :show, :create]
end
