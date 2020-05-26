Rails.application.routes.draw do
  # get 'videos/index'
  # get 'video/index'
  # get 'customers/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :customers, only: [:index, :show]
  resources :videos, only: [:index, :show]  
  
end
