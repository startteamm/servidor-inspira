class Activity < ApplicationRecord
    has_one :activity_type
    has_and_belongs_to_many :users
    validates :title, :date, :time, :speakers_full_name, :speakers_jobs, :activity_type_id, presence: true
end