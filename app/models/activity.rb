class Activity < ApplicationRecord
    has_one :activity_type
    has_and_belongs_to_many :users
    has_and_belongs_to_many :guests
    validates :title, :description, :date, :start_time, 
              :workload, :location, :capacity, :activity_type_id, presence: true
end