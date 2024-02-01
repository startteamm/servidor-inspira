Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  get 'app_auth/codigo' => 'app_auth#codigo'
  post 'app_auth/validar_chave' => 'app_auth#validar_chave'
  get 'app_auth/credenciais_organizer' => 'app_auth#credenciais_organizer'
end
