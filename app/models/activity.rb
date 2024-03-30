class Activity < ApplicationRecord
    has_one :activity_type
    has_and_belongs_to_many :users
    has_and_belongs_to_many :guests
    validates :title, :description, :duration, :date, :start_time, 
              :workload, :location, :capacity, :activity_type_id, :guest_ids, presence: true
end