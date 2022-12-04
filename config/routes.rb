Rails.application.routes.draw do

  get 'home/index', to: 'home#index'

  resources :user



end
