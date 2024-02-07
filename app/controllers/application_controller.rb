class ApplicationController < ActionController::API
  def erro_key_expirada
    render(json: { message: 'Chave expirou! Solicite ao administrador que gere outra chave.' }, status: :bad_request)
  end

  def authenticate_app!
    app = Jwt::Base.decode(request.headers[:Authorization])

    return head(:unauthorized) unless !app.nil? && @app = AppAuth.find(app[0]["id"])
  end
end
