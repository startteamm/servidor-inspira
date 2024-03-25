class TypeTicket < ApplicationRecord
  has_many :tickets
  belongs_to :event

  validates :name, :value, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
