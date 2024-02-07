class AppAuth < ApplicationRecord
  has_secure_password :key, validations: false

  before_create :code_generate

  PRAZO_KEY = 10.minutes

  def prazo_valido?
    (Time.new - last_created_key_at) <= PRAZO_KEY unless last_created_key_at.nil?
  end

  def ativar!
    self.ativo = true
    self.activation_at = Time.new

    self.save
  end

  def gerar_key!
    self.key = Random.alphanumeric(44)
    self.last_created_key_at = Time.new

    self.save
    key
  end

  private

  def code_generate
    self.code = rand(100000..999999).to_s

    code_generate if AppAuth.exists?(code: code)
  end
end
