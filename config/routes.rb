Rails.application.routes.draw do
  # Auth Routes
  post '/login', to: 'auth#login'

  resources :user
end
