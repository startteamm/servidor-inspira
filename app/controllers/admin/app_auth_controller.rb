module Admin
  class AppAuthController < ApplicationController
    before_action :set_app_auth, only: [:ativacao_app]

    def ativacao_app
      return head(:bad_request) unless @app

      if @app.update(employee_name: params[:nome_funcionario], celula: params[:celula])
        render(json: { key: @app.gerar_key! })
      else
        render(json: @app.errors, status: :unprocessable_entity)
      end
    end

    private

    def set_app_auth
      @app = AppAuth.find_by(code: params[:codigo])
    end
  end
end
