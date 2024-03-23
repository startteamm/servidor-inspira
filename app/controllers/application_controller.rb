class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?

  def erro_key_expirada
    render(json: { message: 'Chave expirou! Solicite ao administrador que gere outra chave.' }, status: :bad_request)
  end

  def authenticate_app!
    app = Jwt::Base.decode(request.headers[:Authorization])

    return head(:unauthorized) unless !app.nil? && @app = AppAuth.find(app[0]["id"])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :phone, :phone, :university,
                                                       :birth_date, :gender, :nationality, :rg, :cpf])
  end
end
