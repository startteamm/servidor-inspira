class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :type_ticket

  before_create :generate_x_idempotency_key

  enum tipo: %i[pix cartao]
  enum status: %i[start peding approved]

  validates :response, :tipo, :status, presence: true, on: :update

  def response_json
    JSON.parse(response) if response
  end

  private

  def generate_x_idempotency_key
    self.x_idempotency_key = SecureRandom.uuid

    self.x_idempotency_key = SecureRandom.uuid while Payment.exists?(x_idempotency_key: x_idempotency_key)
  end
end
