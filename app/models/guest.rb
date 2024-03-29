class Guest < ApplicationRecord
    has_and_belongs_to_many :activities
    validates :full_name, :email, :description, presence: true
end