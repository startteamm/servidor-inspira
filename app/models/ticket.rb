class Ticket < ApplicationRecord
  belongs_to :type_ticket
  belongs_to :user

  has_secure_token :code

  validates :code, uniqueness: { case_sensitive: false }

  def validar!
    self.validated = true
    self.save
  end
end
