Rails.application.routes.draw do

  #User routes
  namespace :user_module do
    resources :user
    resources :user_favourite
  end

  namespace :roadmaps_module do
    resources :topic
  end

  #Auth routes
  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
