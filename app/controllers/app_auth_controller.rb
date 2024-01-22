class AppAuthController < ApplicationController
  before_action :set_app_auth, only: [:validar_chave]

  def codigo
    app = AppAuth.create()

    render(json: { codigo: app.code })
  end

  def validar_chave
    return render(json: { message: 'Credenciais inválidas!' }, status: 400) unless @app&.authenticate_key(params[:chave])

    return erro_key_expirada unless @app.prazo_valido?

    @app.ativar!
    render(json: { token: Jwt::Base.encode({ id: @app.id }) })
  end

  private

  def set_app_auth
    @app = AppAuth.find_by(code: params[:codigo])
  end
end
