Rails.application.routes.draw do
  get 'welcome/index'

  devise_for :users
  resources :users

  root "welcome#index"  
end
