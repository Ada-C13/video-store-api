Rails.application.routes.draw do
  
  get '/customers', to: 'customers#index', as: 'customers'
  get '/customers/:id', to: 'customers#show', as: 'customer'
  
  get '/videos', to: 'videos#index', as: 'videos'
  get '/videos/:id', to: 'videos#show', as: 'video'
  post '/videos', to: 'videos#create' 
end
