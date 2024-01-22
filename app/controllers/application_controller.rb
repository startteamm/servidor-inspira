class ApplicationController < ActionController::API
  def erro_key_expirada
    render(json: { message: 'Chave expirou! Solicite ao administrador que gere outra chave.' }, status: :bad_request)
  end
end
