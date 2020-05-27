Rails.application.routes.draw do
  get "/zomg", to: "videos#index", as: "index"
end
