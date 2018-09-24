Rails.application.routes.draw do
  # Auth Routes
  post '/login', to: 'auth#login'
  post '/signup', to: 'auth#signup'

  resources :user, only: [ :update, :destroy]
  get '/user', to: 'users#show'

  resources :company, only: [:create, :update]
  get '/company', to: 'company#show'
  delete '/company/:id/user/:user_id', to: 'company#remove_user'
  post '/company/:id/user', to: 'company#invite_user'
  get '/invite/:invite_id', to: 'company#add_user'

  delete '/project/:project_id/follow/:id', to: 'follow#destroy'
  resources :project, only: [:create, :show, :update, :index, :destroy]
  post '/project/:id/upload', to: 'project#upload'
  post '/project/:project_id/follow', to: 'follow#create'
  get '/contacts', to: 'contact#index'

  get '/download/:follow_id', to: 'follow#download'
end
