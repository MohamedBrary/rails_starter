Rails.application.routes.draw do
  scope module: :api, defaults: {format: :json} do
    %w(v1).each do |version|
      namespace version.to_sym do
        resources :users, only: %w(create update show) do
          collection do
            post :forgot_password
            put :reset_password
          end
        end
        resource :user_token, path: :token, only: %w(create destroy)
      end
    end
  end
  

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}
  devise_scope :user do
    get '/users/auth/:provider/upgrade' => 'omniauth_callbacks#upgrade', as: :user_omniauth_upgrade
    get '/users/auth/:provider/setup', :to => 'omniauth_callbacks#setup'
  end
  resources :users, except: [:new, :create]

  get 'welcome/index'
  root "welcome#index"  
end
