Rails.application.routes.draw do
  get 'customers/index'
  get 'videos/index'
  resources :videos, only: [:index, :show] 
  resources :customers, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
