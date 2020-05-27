Rails.application.routes.draw do

resources :videos
resources :customers, only: [:index, :show]
resources :rentals
end
