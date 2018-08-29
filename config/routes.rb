Rails.application.routes.draw do
  # Auth Routes
  post '/login', to: 'auth#login'

  # Users Routes
  get '/users/:id', to: 'users#show'
  post '/users', to: 'users#create'
  patch '/users/:id', to: 'users#update'
  delete 'users/:id', to: 'users#destroy'

  # Companies Routes
  get '/companies/:id', to: 'companies#show'
  post '/companies', to: 'companies#create'
  patch '/companies/:id', to: 'companies#update'
  delete '/companies/:id', to: 'companies#destroy'

  # Projects Routes
  get '/projects/:id', to: 'projects#show'
  post '/projects', to: 'projects#create'
  patch '/projects/:id', to: 'projects#update'
  delete '/projects/:id', to: 'projects#destroy'

  # Drawings Routes
  get '/drawings/:id', to: 'drawings#show'
  post '/drawings', to: 'drawings#create'
  patch '/drawings/:id', to: 'drawings#update'
  delete '/drawings/:id', to: 'drawings#destroy'
  get '/drawings/:id/:follow_id', to: 'drawings#download'

end
