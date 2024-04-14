Rails.application.routes.draw do
  root 'home#index'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  get 'app_auth/codigo', to: 'app_auth#codigo'
  post 'app_auth/validar_chave', to: 'app_auth#validar_chave'
  get 'app_auth/credenciais_organizador', to: 'app_auth#credenciais_organizador'

  namespace :admin do
    post 'ativacao_app', to: 'app_auth#ativacao_app'
  end

  namespace :api, defaults: { format: :json } do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: { omniauth_callbacks: "api/v1/omniauth_callbacks" }

    namespace :v1 do
      get 'users/:id/tickets', to: 'users#tickets'
      get 'users/:id/tickets/:id_ticket', to: 'users#ticket'
      post 'users/registration_in_activities', to: 'users#registration_in_activities'
      resources :events
      resources :type_tickets
      resources :tickets
      resources :activities
      resources :guests
      get 'tickets/:id/qrcode', to: 'tickets#qrcode'
      put 'tickets/:code/validar_ingresso', to: 'tickets#validar_ingresso'
      namespace :payments do
        post 'tickets/:id_ticket/start_checkout', to: 'tickets#start_checkout'
        post 'tickets/:x_idempotency_key/pix', to: 'tickets#pix'
        post 'tickets/:x_idempotency_key/cartao', to: 'tickets#cartao'
      end
    end
  end
end
