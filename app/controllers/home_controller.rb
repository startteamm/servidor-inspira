class HomeController < ApplicationController
  def index
    render json: { message: 'Bem-vindo a Inspira Design' }
  end
end
