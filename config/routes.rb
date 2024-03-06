Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  root 'home#index'
  devise_for :users, path: "usuario", controllers: { 
    registrations: "users/registrations", 
    sessions: "users/sessions",
    omniauth_callbacks: 'users/omniauth_callbacks' 
  }, path_names: { sign_up: 'cadastro', sign_in: 'login', sign_out: 'sair', password: 'senha',
                   new: 'criar', cancel: 'cancelar', confirmation: 'confirmacao'}
                   
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

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
      resources :type_tickets
      resources :tickets
      get 'tickets/:id/qrcode', to: 'tickets#qrcode'
      put 'tickets/:code/validar_ingresso', to: 'tickets#validar_ingresso'
    end
  end

  get '/lojinha', to: 'shop#index'
  get '/ingressos', to: 'ticket#index'
  get '/programacao', to: 'schedule#index'
  get '/quem-somos', to: 'about#index'
  get '/ultimas-edicoes', to: 'about#past_events'
  get '/equipes', to: 'about#teams'
  get '/faq', to: 'about#faq'
  get '/ajuda', to: 'about#help'
end
