Rails.application.routes.draw do
  # Auth Routes
  post '/login', to: 'auth#login'
  post '/signup', to: 'auth#signup'

  resources :user, only: [ :update, :destroy]
  get '/user', to: 'users#show'

  resources :company, only: [:create]
  get '/company', to: 'company#show'
  resources :project, only: [:create, :show, :update, :index]
  post '/project/:id/upload', to: 'project#upload'
  post '/project/:project_id/follow', to: 'follow#create'
  delete '/project/:project_id/follow/:id', to: 'follow#destroy'
  get '/contacts', to: 'contact#index'
end
