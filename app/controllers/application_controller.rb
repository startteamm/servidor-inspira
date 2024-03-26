class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :enable_validate_account_update_params, only: :update, if: :devise_controller?

  def erro_key_expirada
    render(json: { message: 'Chave expirou! Solicite ao administrador que gere outra chave.' }, status: :bad_request)
  end

  def authenticate_app!
    app = Jwt::Base.decode(request.headers[:Authorization])

    head(:unauthorized) unless !app.nil? && @app = AppAuth.find(app[0]['id'])
  end

  protected

  def configure_permitted_parameters
    parameters = %i[full_name phone university birth_date gender nationality rg cpf address]

    devise_parameter_sanitizer.permit(:sign_up, keys: parameters)
    devise_parameter_sanitizer.permit(:account_update, keys: parameters)
  end

  private

  def enable_validate_account_update_params
    if current_api_user && !current_api_user.validate_account_update_params
      current_api_user.enable_validate_account_update_params!
    end
  end
end
