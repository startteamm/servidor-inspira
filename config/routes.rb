Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get 'app_auth/codigo', to: 'app_auth#codigo'
  post 'app_auth/validar_chave', to: 'app_auth#validar_chave'
  get 'app_auth/credenciais_organizador', to: 'app_auth#credenciais_organizador'

  namespace :admin do
    post 'ativacao_app', to: 'app_auth#ativacao_app'
  end

  namespace :api do
    namespace :v1 do
      resources :type_ticket
      resources :ticket
      get 'ticket/:id/qrcode', to: 'ticket#qrcode'
      put 'ticket/:code/validar_ingresso', to: 'ticket#validar_ingresso'
    end
  end
end
