class TypeTicket < ApplicationRecord
  belongs_to :event
  has_many :tickets
  has_many :payments
  has_many :users, through: :payments

  validates :name, :value, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  def as_json_checkout
    {
      image: image,
      name: name,
      description: description,
      value: value
    }
  end
end
