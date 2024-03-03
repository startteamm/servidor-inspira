class Ticket < ApplicationRecord
  belongs_to :type_ticket

  has_secure_token :code

  def validado?
    validated
  end

  def validar!
    self.validated = true
    self.save
  end
end
