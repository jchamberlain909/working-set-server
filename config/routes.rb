Rails.application.routes.draw do
  post '/login', to: 'auth#login'

  resources :users, only: [:create, :index, :show, :update, :destroy]
  resources :companies, only: [:create, :index, :show, :update, :destroy]

  

end
