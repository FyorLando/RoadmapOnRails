Rails.application.routes.draw do

  root 'session#home'

  get 'home/index', to: 'home#index'

  #User routes
  resources :user, only: [:new, :create, :index, :show]

  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'



end
