Rails.application.routes.draw do
  
  get '/customers', to: 'customers#index', as: 'customers'
  get '/customers/:id', to: 'customers#show', as: 'customer'
  
end
