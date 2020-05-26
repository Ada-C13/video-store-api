Rails.application.routes.draw do

  get 'videos/index'
  get 'videos/show'
  get 'videos/create'
  get 'customers/index'
  get 'customers/show'
  resources :customers, only:[:index, :show]

  resources :videos, only:[:index, :show, :create]

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
