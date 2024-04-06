class TypeTicket < ApplicationRecord
  belongs_to :event
  has_many :tickets
  has_many :payments
  has_many :users, through: :payments

  validates :name, :value, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
