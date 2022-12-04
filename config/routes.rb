Rails.application.routes.draw do

  #User routes
  namespace :user_module do
    resources :user, only: [:new, :create, :index, :show]
    resources :user_favourite
  end

  #Auth routes
  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'




end
