class Event < ApplicationRecord
  has_many :type_tickets

  validates :name, :start_date, :end_date, presence: true
  validates :start_date, :end_date, date: true
  validates :start_date_sale_ticket, :end_date_sale_ticket,
             date: true, if: -> { start_date_sale_ticket || end_date_sale_ticket }
  validates :cep, format: { with: /(^[0-9]{5})-([0-9]{3}$)/ }
end
