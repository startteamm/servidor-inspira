class TypeTicket < ApplicationRecord
  has_many :ticket, dependent: :destroy

  validates :name, :value, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
