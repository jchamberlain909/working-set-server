Rails.application.routes.draw do
  post '/login', to: 'auth#login'

  resources :users, only: [:create, :index, :show, :update, :destroy]
  resources :companies, only: [:create, :index, :show, :update, :destroy]

  get '/companies/:company_id/projects', to: 'projects#index'
  get '/companies/:company_id/projects/:project_id', to: 'projects#show'
  post '/companies/:company_id/projects', to: 'projects#create'
  patch 'companies/:company_id/projects/:project_id', to: 'projects#update'
  delete 'companies/:company_id/projects/:project_id', to: 'projects#destroy'

end
