Rails.application.routes.draw do
  # Auth Routes
  post '/login', to: 'auth#login'
  post '/signup', to: 'auth#signup'

  resources :user, only: [ :update, :destroy]
  get '/user', to: 'users#show'

  resources :company, only: [:create]
  resources :project, only: [:create, :show, :update]
  
end
