class Activity < ApplicationRecord
    has_one :activity_type
    has_and_belongs_to_many :users
    validates :title, :description, :duration, :date, :start_time, 
              :workload, :guest_full_name, :guest_description, :guest_email,
              :location, :capacity, :activity_type_id, presence: true
end