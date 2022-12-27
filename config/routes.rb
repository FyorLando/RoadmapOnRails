Rails.application.routes.draw do

  #User routes
  namespace :user_module do
    get '/user/me', to: 'user#me'
    resources :user
    resources :user_favourite
    resources :user_read
    resources :role
  end

  namespace :roadmaps_module do
    resources :topic
    resources :road_node
    resources :attachment
  end

  namespace :rates_module do
    resources :topic_rate
    resources :node_rate
  end

  #Auth routes
  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
